class RoutesController < ApplicationController
    layout "basic"
    respond_to :html, :json
	before_filter :signed_in_user, only: [:create, :destroy, :show]
	before_filter :correct_user, only:[ :destroy ]
	
	def new
	  @route = current_user.routes.build
	  @types = ActivityType.all
      @user = current_user
      @info = Info.find_by_user_id(@user.id)
	end
	
	def addphotos	  
	  @route = Route.find(params[:route_id].split("=>")[1].gsub("}","").to_i)			#magic to obtain ids
	  @user = User.find(params[:user_id].split("=>")[1])								# -||-	
	  images = params[:file_upload]["upload"]
	  images.each do |image|
	    asset = Asset.new(:route_id => @route.id, :user_id => @user.id,	
			:image_file_name => image.original_filename,
			:image_content_type => image.content_type)
	    asset.save!																		#save to DB
	    uploadFile(image, @route.id, @user.id, asset.id)								#copy image to given folder
	  end
	  flash[:success] = "Photos were added!"
	  redirect_to @route
	end
	
	def uploadFile(image, route_id, user_id, savedphoto_id)
		post = Datafile.save(image, route_id, user_id, savedphoto_id)
	end
	
	def create
	  @user = current_user
	  @route = current_user.routes.build(params[:route])
	  @types = ActivityType.all
	  activity = params[:type_ids]
	  if activity.nil?
        flash[:notice] = "At least one type of route must be selected!"
	    render :new
	  else
		  if @route.save
			activity.each { |act|
				activityRelation = RouteActivityRelation.new
				activityRelation.activity_type_id = act
				activityRelation.route_id = @route.id
				activityRelation.save!
			}
			assignUserId(@route.id)
			flash[:success] = "Route created!"
			redirect_to current_user
		  else
			render 'new'
		  end
	  end
	end
	
	def assignUserId(route_id)
		a = Asset.new
		images_without_user = a.notUsersSet(route_id)
		images_without_user.each { |image|
				image.user_id = current_user.id
				image.save
		}		
	end
	
	#if the route is used in some map - the "owner" of the event becomes the owner of the route instead the original user 
	def destroy
	  photos = @route.assets					#delete photos associated with given route
	  delete_photos(photos)						#
	  event = Event.find_by_route_id(@route.id)
	  unless event.nil?
	    @route.update_attributes(:user_id => event.user_id)	
		user = User.find(event.user_id)
		flash[:success] = "Route was handed to another user (it is still used in an event): #{user.email}!"
		redirect_to current_user
	  else
		@route.destroy
		flash[:success] = "Route was deleted!"
		redirect_to current_user
	  end
	end
	
	def delete_photos(photos)
	  photos.each do |photo|
	    FileUtils.rm_rf("app/assets/images/photogalleries/"+photo.id.to_s)
	  end
	end
	
	def show
	  @route = Route.find(params[:id])
	  @user = current_user
      @info = Info.find_by_user_id(@user.id)
	  @activities = @route.activity_types
	  @comment = RouteCommentRelationship.new
	  @allcomments = @route.all_comments(@route.id)
	  @allgalerists = galerist(@route.id)
      @thumbnails = []
      @allgalerists.each do |galerist|
        @thumbnails[galerist.id] = @user.get_photos_from_galerist_to_route(galerist.id, @route.id).first
      end
	end
	
	def galerist(route_id)
		allgalerist_id_duplicated = current_user.get_galerist_ids(route_id)
		allgalerist_id = []
		allgalerist_id_duplicated.each { |dup|
			if(!allgalerist_id.include?(dup.user_id))
				allgalerist_id << dup.user_id
			end
		}
		allgalerists = []
		allgalerist_id.each { |id|
			allgalerists << User.find(id)	
		}
		allgalerists
	end
	
	def photogallery
		@user = current_user
		@photo_user = User.find(params[:user_id])
		@route = Route.find(params[:route_id])
		@all_photos = current_user.get_photos_from_galerist_to_route(@photo_user.id, @route.id)
	end
	
	
	
	def wanters
		@route = Route.find(params[:route_id])
		want_try = WantTryRelationship.new	
		want_try.wanter_id = current_user.id
		want_try.wanted_route_id = @route.id
		if want_try.save
			flash[:success] = "You WANT TO TRY the route"
			redirect_to @route
		else
			redirect_to current_user
		end
	end
	
	def unwant		
		@route = Route.find(params[:id])
		current_user.not_want_try!(@route.id)
		redirect_to @route
	end
	
	def untry	
		@route = Route.find(params[:id])
		current_user.not_tried!(@route.id)
		redirect_to @route
	end
	
	def triers
		@route = Route.find(params[:route_id])
		tried = TriedRelationship.new
		tried.trier_id = current_user.id
		tried.tried_route_id = @route.id
		if tried.save
			flash[:success] = "You've TRIED the route"
			unwant
		else
			redirect_to current_user
		end
	end
	
    
	private
	def correct_user
		@route = current_user.routes.find_by_id(params[:id])							
		redirect_to current_user if @route.nil?	
	end
end

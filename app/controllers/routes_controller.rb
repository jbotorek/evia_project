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
	  5.times {@route.assets.build}
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
			flash[:success] = "Route created!"
			redirect_to current_user
		  else
			render 'new'
		  end
	  end
	end
	
	#if the route is used in some map - the "owner" of the event becomes the owner of the route instead the original user 
	def destroy
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
	
	def show
	  @route = Route.find(params[:id])
	  @user = current_user
      @info = Info.find_by_user_id(@user.id)
	  @activities = @route.activity_types
	  @comment = RouteCommentRelationship.new
	  @allcomments = @route.all_comments(@route.id)
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

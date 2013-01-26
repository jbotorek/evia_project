class RoutesController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy, :show]
	before_filter :correct_user, only:[ :destroy ]
	
	def new
	  @route = current_user.routes.build
	  @types = ActivityType.all
	end
	
	def create
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
			render :new
		  end
		end
	end
	
	def destroy
	  @route.destroy
	  flash[:success] = "Route was deleted!"
	  redirect_to current_user
	end
	
	def show
	  @route = Route.find(params[:id])
	  @user = current_user
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
		@route = Route.find(params[:route_id])
		current_user.not_want_try!(@route.id)
		redirect_to @route
	end
	
	def triers
		@route = Route.find(params[:route_id])
		tried = TriedRelationship.new
		tried.trier_id = current_user.id
		tried.tried_route_id = @route.id
		if tried.save
			flash[:success] = "You've TRIED the route"
			redirect_to @route
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

class RoutesController < ApplicationController
	before_filter :signed_in_user, only: [:create, :destroy, :show]
	before_filter :correct_user, only:[ :destroy ]
	
	def new
	  @route = current_user.routes.build
	end
	
	def create
	  @route = current_user.routes.build(params[:route])
	  if @route.save
		flash[:success] = "Route created!"
		redirect_to current_user
	  else
	    render 'new'
	  end
	end
	
	def destroy
	  @route.destroy
	  flash[:success] = "Route was deleted!"
	  redirect_to root_url
	end
	
	def show
	  @route = Route.find(params[:id])
	  @user = current_user
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
	
	private
	def correct_user
		@route = current_user.routes.find_by_id(params[:id])							
		redirect_to current_user if @route.nil?	
	end
end

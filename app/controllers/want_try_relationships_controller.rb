class RoutesController < ApplicationController	
  def new
  end
  
  def create  
    @route = Route.find(params[:want_try_relationship][:wanted_route_id])
	current_user.want_try!(@route)
	redirect_to @user
  end
  
  def destroy
    @route = Want_try_relationship.find(params[:id]).route_id
    current_user.unfollow!(@route)
    redirect_to @user
  end
  
end

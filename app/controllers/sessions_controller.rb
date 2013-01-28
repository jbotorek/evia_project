class SessionsController < ApplicationController
  layout "basic"
  def new
  end
	

  def create
	user = User.find_by_email(params[:session][:email].downcase)
    if user 
	  if user && user.authenticate(params[:session][:password])
	    sign_in user
		flash[:success] = "Welcome to the eVia - It's time to hit the road"
		redirect_to user
	  else
	    flash.now[:error] = "You have misspelled your password, please try it one more time."
		render 'new'
	  end
	else
	  flash[:error] = "User with the given email #{params[:session][:email]} doesn\'t exist, please create one"
	  redirect_to new_user_path
	end
  end
  
  
  def destroy
    sign_out
	flash[:success] = "You were successfully signed out from the eVia "
	redirect_to root_url
  end
  
end

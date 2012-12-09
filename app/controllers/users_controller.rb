class UsersController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update]
	before_filter :correct_user,   only: [:edit, :update]
	before_filter :admin_user,     only: :destroy

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  def create
    @user = User.new(params[:user])
	if @user.save
		sign_in @user
		flash[:success] = "User #{ @user.email } was successfully created"
		redirect_to @user
	else
	   render 'new'
	end
  end

  # PUT /users/1
  def update
	if @user.update_attributes(params[:user])
	  flash[:success] = "Profile updated"
	  sign_in @user
	  redirect_to @user
	else
	  render 'edit'
	end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user = User.find(params[:id])
	user.destroy
	flash[:success] = "User #{user.name} was deleted"
	redirect_to users_url
  end
  
  
  def signed_in_user
    redirect_to signin_url, notice: "Please sign in." unless signed_in?
  end
  
  def correct_user
	  @user = User.find(params[:id])
	  redirect_to(root_path) unless current_user?(@user)
  end
  
  def admin_user
    redirect_to(root_path) unless current_user.admin?			
  end
  
end

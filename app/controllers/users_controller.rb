class UsersController < ApplicationController
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
		flash[:success] = "User #{ @user.email } was successfully created"
		redirect_to @user
	else
	   render 'new'
	end
  end

  # PUT /users/1
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy
	redirect_to users_url
  end
end

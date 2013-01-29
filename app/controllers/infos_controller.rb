class InfosController < ApplicationController
	layout "basic"
	
	def new
	    @info = Info.new
	end
	
	def create
	  @info = Info.new(params[:info])
	  @info.user_id = current_user.id
	  if @info.save
		flash[:success] = "Info created!"
		redirect_to current_user
	  else
	    render 'new'
	  end
	end
	
	def edit
        @user = User.find(params[:id])
		@info = Info.find_by_user_id(current_user.id)
	end
	
	def update
		if Info.find_by_user_id(current_user.id).update_attributes(params[:info])
		  flash[:success] = "Profile information updated"
		  redirect_to current_user
		else
			render 'edit'
		end
	end
	
	private
	def correct_user
		@info = current_user.infos.find_by_id(params[:id])							
		redirect_to current_user if @info.nil?	
	end
end

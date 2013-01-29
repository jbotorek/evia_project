class StaticPagesController < ApplicationController
  layout "basic"
  def home
    if @user = current_user
        redirect_to @user
    end
    @user = User.new
    if signed_in?		
	end
  end
end

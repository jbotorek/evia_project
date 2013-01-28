class StaticPagesController < ApplicationController
  layout "basic"
  def home
    @user = User.new
    if signed_in?		
	end
  end
end

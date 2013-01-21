class RouteCommentRelationshipsController < ApplicationController
  def create
	@comment = RouteCommentRelationship.new
	@comment.text = params[:route_comment_relationship][:text]
	@comment.route_id = params[:route_id].split(/[=>{}]/)[3]
	@comment.commenter_id = params[:commenter_id].split(/[=>{}]/)[3]
	if @comment.save
	  flash[:success] = "Comment created!"
      redirect_to '/routes/'+@comment.route_id.to_s
    else
		flash[:success] = @comment.text + "			was not created"
		render 'static_pages/home'
	end
  end

  def destroy
	comment = RouteCommentRelationship.find(params[:id])
	comment.destroy
	flash[:success] = 'Comment deleted!'
	redirect_to (root_url.to_s + "routes/" + params[:route_id].to_s)
  end
end

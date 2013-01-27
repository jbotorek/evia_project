class EventCommentRelationshipsController < ApplicationController
  def create
	@comment = EventCommentRelationship.new
	@comment.text = params[:event_comment_relationship][:text]
	@comment.event_id = params[:event_id].split(/[=>{}]/)[3]
	@comment.commenter_id = params[:commenter_id].split(/[=>{}]/)[3]
	if @comment.save
	  flash[:success] = "Comment created!"
      redirect_to '/events/'+@comment.event_id.to_s
    else
		flash[:error] = @comment.text + "			was not created"
		render 'static_pages/home'
	end
  end

  def destroy
	comment = EventCommentRelationship.find(params[:id])
	comment.destroy
	flash[:success] = 'Comment deleted!'
	redirect_to (root_url.to_s + "events/" + params[:event_id].to_s)
  end
end

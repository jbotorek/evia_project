class EventsController < ApplicationController
  layout "basic"
  before_filter :signed_in_user
  def new
    @event = Event.new
	@types = ActivityType.all
	@routes = Route.all
    @user = current_user
    @info = Info.find_by_user_id(@user.id)
  end

 
  def create
	@user = current_user
	@event = current_user.events.build(params[:event])
	@event.user_id = current_user.id
	if @event.save
		flash[:success] = "New Event Created!"
		redirect_to current_user
	else
		flash[:success] = "New Event Was NOT Created! - check your fields!"
			#add fields check - like in the situation of new user form!!!!
		redirect_to new_event_path
	end	
	
  end

  def destroy
	@event = Event.find(params[:id])
	@event.destroy
	flash[:success] = "Event was deleted!"
	redirect_to current_user
  end

  def show
	@event = Event.find(params[:id])
	@route = Route.find(@event.route_id)
	@activity = ActivityType.find(@event.event_type_id)
    @activities = @route.activity_types
	@comment = EventCommentRelationship.new
	@allcomments = @event.all_comments(@event.id)
	@user = current_user
    @info = Info.find_by_user_id(@user.id)
  end
  
  def edit
	@event = Event.find(params[:id])
	@types = ActivityType.all
	@routes = Route.all
	@user = current_user
    @info = Info.find_by_user_id(@user.id)
  end

  def update
	@user = current_user
	if Event.find(params[:id]).update_attributes(params[:event])
	  flash[:success] = "Event specifications updated"
	  redirect_to current_user
	else
		render 'edit'
	end
  end
  
  def attend
	@event = Event.find(params[:event_id])
	attend = EventAttend.new	
	attend.attendee_id = current_user.id
	attend.attend_event_id = @event.id
	if attend.save
		flash[:succes] = "You want to attend the event"
		redirect_to @event
	else
		redirect_to current_user
	end
  end
  
  def unattend
	@event = Event.find(params[:event_id])
	current_user.unattend!(@event)
	redirect_to @event
  end
  
end

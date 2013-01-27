class EventsController < ApplicationController
  before_filter :signed_in_user

  def new
    @event = Event.new
	@types = ActivityType.all
	@routes = Route.all
  end

 
  def create
	@event = current_user.events.build(params[:event])
	@types = ActivityType.all						#needed for verification
	@routes = Route.all								#needed for verification
	@event.user_id = current_user.id
	if @event.save
		flash[:success] = "New Event Created!"
		redirect_to current_user
	else
		flash[:notice] = "New Event Was NOT Created! - check your fields!"
		render 'new'
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
	@allattendee = @event.attendees
	@comment = EventCommentRelationship.new
	@allcomments = @event.all_comments(@event.id)
  end
  
  def edit
	@event = Event.find(params[:id])
	@types = ActivityType.all
	@routes = Route.all
  end

  def update
	@event = Event.find(params[:id])		#needed for verification
	@types = ActivityType.all				#needed for verification
	@routes = Route.all						#needed for verification
	if Event.find(params[:id]).update_attributes(params[:event])
	  flash[:success] = "Event specifications updated"
	  redirect_to current_user
	else
		flash[:notice] = "Event was not updated - fields must not be empty"
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

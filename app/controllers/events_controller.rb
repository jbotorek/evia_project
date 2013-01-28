class EventsController < ApplicationController
  layout "basic"
  before_filter :signed_in_user

  def new
    @event = Event.new
	@types = ActivityType.all
	@routes = Route.all
  end

 
  def create
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
  end
  
  def edit
	@event = Event.find(params[:id])
	@types = ActivityType.all
	@routes = Route.all
  end

  def update
	if Event.find(params[:id]).update_attributes(params[:event])
	  flash[:success] = "Event specifications updated"
	  redirect_to current_user
	else
		render 'edit'
	end
  end
  
  
end

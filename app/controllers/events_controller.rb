class EventsController < ApplicationController
    before_action :verified_user

    def index
        @events = Event.all
    end

    def new
        @event = Event.new
        @event.requirements.build
    end

    def create
        Event.create(event_params)
        #if @event.exists?
        redirect_to '/events/show'
#        else
#            render 'new'
        #end
    end

    def show
        @event = Event.find_by(id: params[:id])
    end

    def edit
        @event = Event.find_by(id: params[:id])
        
    end

    def update
        event = Event.find_by(id: params[:id])
        event.update(event_params)
        redirect_to events_path(@event)
    end

    def destroy
    end

    private

        def event_params
            params.require(:event).permit(
                :start, :finish, :title,
                requirements_attributes: [
                    :id, :field, :goals, :food_truck, :other, :empty_field
                ]
            )
        end


end

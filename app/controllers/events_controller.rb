class EventsController < ApplicationController
    def index
        @events = Event.all
    end

    def new
        @event = Event.new(:user_id => params[:user_id])
        @event.fields.build.requirements.build
    end

    def create
        @event = Event.create(event_params)
        @event.user_id = current_user.id
        @event.save!
        byebug
        render 'events/show'
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
        event = Event.find_by(id: params[:id])
        event.delete
        redirect_to '/events'
    end

    private

        def event_params
            params.require(:event).permit(
                :start, :finish, :title, :user_id,
                    fields_attributes: [
                        :name, :event_id,
                            requirements_attributes: [
                                :goals, :food_truck, :other, :empty_field, :field_id
                            ]
                        ]
                )
        end

        


end

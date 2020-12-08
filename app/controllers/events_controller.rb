class EventsController < ApplicationController
    before_action :exclusive_field, only: [:new, :create]

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
        exclusive_field
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
                        :field_name, :event_id,
                            requirements_attributes: [
                                :goals, :food_truck, :other, :empty_field, :field_id
                            ]
                        ]
                )
        end

        def exclusive_field
            Field.all.each do |f|
                if (Field.where("event_id = ?", @event.id) == f.field_name)
                    Event.all.each do |e|
                        if (@event.start..@event.finish).overlaps?(e.start..e.finish)
                            flash[:message] = "An event already exists at this time and field"
                        else
                            flash[:message] = "Event created"

                        end
                    end
                end
            end    
        end

end

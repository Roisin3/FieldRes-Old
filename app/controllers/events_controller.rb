class EventsController < ApplicationController

    def index
        @events = Event.user_id_finder(current_user)
    end

    def new
        @event = Event.new(:user_id => params[:user_id])
        @event.fields.build.requirements.build
    end

    def create
        @event = Event.create(event_params)
        @event.user_id = current_user.id
        if exclusive_field == nil
            @event.save!
            redirect_to events_path(@event)
        else
            flash[:notice] = "Another event has already reserved this field."
            redirect_to events_new_path
        end
    end

    def show
        @events = Event.user_id_finder(current_user)
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


        def exclusive_field
            Event.field_finder(params[:event][:fields_attributes]["0"][:name]).detect do |e|
                (params[:event][:start]..params[:event][:finish]).overlaps?(e.start.strftime("%FT%H:%M")..e.finish.strftime("%FT%H:%M"))
            end
        end
        
        # def unused_field
        #     @event.save!
        #     redirect_to events_path(@event)
        # end
end
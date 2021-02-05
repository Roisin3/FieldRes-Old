class EventsController < ApplicationController
    before_action :event_setter, except: [:index, :new, :create, :show]

    def index
        @events = Event.user_id_finder(current_user)
    end

    def new
        @event = Event.new(:user_id => params[:user_id])
        @event.requirements.build.fields.build
    end

    def create
        # @event = Event.create(event_params)
        # @event.user_id = current_user.id
        @event = current_user.events.build(event_params)
        byebug
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
       # @event = Event.find_by(id: params[:id])    
    end

    def update
      #  event = Event.find_by(id: params[:id])
        event.update(event_params)
        redirect_to events_path(@event)
    end

    def destroy
       # event = Event.find_by(id: params[:id])
        event.delete
        redirect_to '/events'
    end

    private

        def event_setter
            event = Event.find_by(id: params[:id])
        end

        def event_params
            params.require(:event).permit(
                :start, :finish, :title, :user_id,
                requirements_attributes: [
                    :goals, :food_truck, :other, :empty_field, :event_id, 
                        fields_attributes: [
                            :name, :requirement_id
                        ]
                ]
            )
        end


        def exclusive_field
            Event.field_finder(params[:event][:requirements_attributes]['0'][:fields_attributes]['0'][:name]).detect do |e|
                (params[:event][:start]..params[:event][:finish]).overlaps?(e.start.strftime("%FT%H:%M")..e.finish.strftime("%FT%H:%M"))
            end
        





            # Event.field_finder(params[:event][:fields_attributes]["0"][:name]).detect do |e|
            #     (params[:event][:start]..params[:event][:finish]).overlaps?(e.start.strftime("%FT%H:%M")..e.finish.strftime("%FT%H:%M"))
            # end
        end
end
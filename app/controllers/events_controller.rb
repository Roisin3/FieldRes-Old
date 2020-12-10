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
        exclusive_field
        # @event.save!
        # redirect_to event_path(@event)
        # redirect_to '/events/show'
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

        def exclusive_field
            Field.all.each do |f| #provides access to Field model
                params[:event][:fields_attributes].values.each do |a| #takes all of Fields params nested in Event
                    # if a[:name] == f.name  # checks two all Field names vs name provided in form and                       
                    #     Event.all.each do |e| # if .names provided match gets all datetimes from Event. PROBLEM LIES HERE? This line is checking all Events if a Field.name matches NOT only matching names
                    e = Event.all.where("a[:name] == f.name")
                    byebug
                            if (params[:event][:start]..params[:event][:finish]).overlaps?(e.start..e.finish) #compares form given event params with Events datetimes
                                flash[:message] = "An event already exists at this time and field."
                                return
                                redirect_to new_event_path                                
                            else                                
                                @event.save!                                
                                flash[:message] = "Event created."
                                return
                                redirect_to event_path(@event)                                
                            end
                        #end
                    end
                end
            end
        #end


        # def exclusive_field
        #     Field.all.each do |f|
        #         if params[:fields][:name] == f.name
        #           Event.all.each do |e|
        #                 if (params[:start]..params[:finish]).overlaps?(e.start..e.finish)
        #                     flash[:message] = "An event already exists at this time and field"
        #                     redirect_to 'events/show'
        #                 else
        #                     flash[:message] = "Event created"
        #                     redirect_to 'events/show'
        #                 end
        #             end
        #         end
        #     end    
        # end
        


end

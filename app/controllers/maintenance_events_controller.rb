class MaintenanceEventsController < ApplicationController
  def index
    matching_maintenance_events = MaintenanceEvent.all

    @list_of_maintenance_events = matching_maintenance_events.order({ :created_at => :desc })

    render({ :template => "maintenance_events/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_maintenance_events = MaintenanceEvent.where({ :id => the_id })

    @the_maintenance_event = matching_maintenance_events.at(0)

    render({ :template => "maintenance_events/show.html.erb" })
  end

  def create
    the_maintenance_event = MaintenanceEvent.new
    the_maintenance_event.description = params.fetch("query_description")
    the_maintenance_event.maintenance_date = params.fetch("query_maintenance_date")
    the_maintenance_event.house_id = params.fetch("query_house_id")

    if the_maintenance_event.valid?
      the_maintenance_event.save
      redirect_to("/maintenance_events", { :notice => "Maintenance event created successfully." })
    else
      redirect_to("/maintenance_events", { :alert => the_maintenance_event.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_maintenance_event = MaintenanceEvent.where({ :id => the_id }).at(0)

    the_maintenance_event.description = params.fetch("query_description")
    the_maintenance_event.maintenance_date = params.fetch("query_maintenance_date")
    the_maintenance_event.house_id = params.fetch("query_house_id")

    if the_maintenance_event.valid?
      the_maintenance_event.save
      redirect_to("/maintenance_events/#{the_maintenance_event.id}", { :notice => "Maintenance event updated successfully."} )
    else
      redirect_to("/maintenance_events/#{the_maintenance_event.id}", { :alert => the_maintenance_event.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_maintenance_event = MaintenanceEvent.where({ :id => the_id }).at(0)

    the_maintenance_event.destroy

    redirect_to("/maintenance_events", { :notice => "Maintenance event deleted successfully."} )
  end
end

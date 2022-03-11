class AppliancesController < ApplicationController
  def index
    matching_appliances = @current_user.appliances.all

    @list_of_appliances = matching_appliances.order({ :category => :desc, :year => :desc })

    render({ :template => "appliances/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_appliances = Appliance.where({ :id => the_id })

    @the_appliance = matching_appliances.at(0)

    render({ :template => "appliances/show.html.erb" })
  end

  def create
    the_appliance = Appliance.new
    the_appliance.appliance_type = params.fetch("query_appliance_type")

    if the_appliance.appliance_type.in?(['Furnace','Water Heater','Air Conditioner','Sump Pump'])
      the_appliance.category = 'Mechanical'
    elsif the_appliance.appliance_type.in?(['Range','Oven','Stove','Microwave','Dishwasher'])
      the_appliance.category = 'Kitchen'
    elsif the_appliance.appliance_type.in?(['Washing Machine','Dryer'])
      the_appliance.category = 'Laundry'
    else
      the_appliance.category = 'Other'
    end

    the_appliance.make = params.fetch("query_make")
    the_appliance.model = params.fetch("query_model")
    the_appliance.year = params.fetch("query_year")
    the_appliance.last_serviced = params.fetch("query_last_serviced")
    
    if the_appliance.appliance_type.in?(['Furnace','Water Heater'])
      the_appliance.service_due = the_appliance.last_serviced + 365
    end

    the_appliance.notes = params.fetch("query_notes")
    the_appliance.house_id = params.fetch("query_house_id")
    the_appliance.contact_id = params.fetch("query_contact_id")

    if the_appliance.valid?
      the_appliance.save
      redirect_to("/appliances", { :notice => "Appliance created successfully." })
    else
      redirect_to("/appliances", { :alert => the_appliance.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_appliance = Appliance.where({ :id => the_id }).at(0)

    the_appliance.appliance_type = params.fetch("query_appliance_type")

    if the_appliance.appliance_type.in?(['Furnace','Water Heater','Air Conditioner','Sump Pump'])
      the_appliance.category = 'Mechanical'
    elsif the_appliance.appliance_type.in?(['Range','Oven','Stove','Microwave','Dishwasher'])
      the_appliance.category = 'Kitchen'
    elsif the_appliance.appliance_type.in?(['Washing Machine','Dryer'])
      the_appliance.category = 'Laundry'
    else
      the_appliance.category = 'Other'
    end

    the_appliance.make = params.fetch("query_make")
    the_appliance.model = params.fetch("query_model")
    the_appliance.year = params.fetch("query_year")
    the_appliance.last_serviced = params.fetch("query_last_serviced")
    
    if the_appliance.appliance_type.in?(['Furnace','Water Heater'])
      the_appliance.service_due = the_appliance.last_serviced + 365
    end

    the_appliance.notes = params.fetch("query_notes")
    the_appliance.house_id = params.fetch("query_house_id")
    the_appliance.contact_id = params.fetch("query_contact_id")

    if the_appliance.valid?
      the_appliance.save
      redirect_to("/appliances/#{the_appliance.id}", { :notice => "Appliance updated successfully."} )
    else
      redirect_to("/appliances/#{the_appliance.id}", { :alert => the_appliance.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_appliance = Appliance.where({ :id => the_id }).at(0)

    the_appliance.destroy

    redirect_to("/appliances", { :notice => "Appliance deleted successfully."} )
  end
end

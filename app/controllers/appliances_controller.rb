class AppliancesController < ApplicationController
  def index
    matching_appliances = @current_user.appliances.all

    @q = matching_appliances.order({ :category => :desc, :year => :desc }).ransack(params[:q])

    @list_of_appliances = @q.result

    @possible_appliance_types = ["Air Conditioner","Water Heater","Sump Pump","Furnace","Range","Oven",
                                "Stove","Microwave","Dishwasher","Washing Machine","Dryer","Other"]

    render({ :template => "appliances/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_appliances = Appliance.where({ :id => the_id })

    @the_appliance = matching_appliances.at(0)

    @possible_appliance_types = ["Air Conditioner","Water Heater","Sump Pump","Furnace","Refrigerator","Range","Oven",
                                "Stove","Microwave","Dishwasher","Washing Machine","Dryer","Other"]

    if @the_appliance.appliance_type == "Furnace"
      @appliance_image = 'https://www.servicechampions.net/wp-content/uploads/2015/03/new-furnace-installation-1.jpg'
    elsif @the_appliance.appliance_type == "Sump Pump"
      @appliance_image = "https://mastertechtexas.com/wp-content/uploads/2021/02/Sump-Pump.jpg"
    elsif @the_appliance.appliance_type == "Dishwasher"
      @appliance_image = "https://pisces.bbystatic.com/image2/BestBuy_US/images/products/6436/6436850_sd.jpg"
    elsif @the_appliance.appliance_type == "Air Conditioner"
      @appliance_image = "https://www.solaceheatingandair.com/site/wp-content/uploads/ac-installation.jpg"
    elsif @the_appliance.appliance_type == "Water Heater"
      @appliance_image = "https://cf-images.us-east-1.prod.boltdns.net/v1/static/66036796001/42d3482c-eac1-444b-9c22-c4557792db69/a0ea7463-aa04-4096-9df3-971632759924/960x540/match/image.jpg"
    elsif @the_appliance.appliance_type == "Washing Machine"
      @appliance_image = "https://www.lg.com/us/images/washers/md06098736/gallery/desktop-03.jpg"
    elsif @the_appliance.appliance_type == "Dryer"
      @appliance_image = "https://www.shopmyexchange.com/products/images/xlarge/1869477_3550.jpg"
    elsif @the_appliance.appliance_type == "Range"
      @appliance_image = "https://images.homedepot.ca/productimages/p_1001529634.jpg?wid=1000&hei=1000&op_sharpen=1&product-images=l"
    elsif @the_appliance.appliance_type == "Oven"
      @appliance_image = "https://cdn11.bigcommerce.com/s-dj46qhetxl/images/stencil/1280x1280/products/123765/271987/Dispatcher_RequestType_Image&Name_24051431__03318.1634382668.jpg?c=1"
    elsif @the_appliance.appliance_type == "Microwave"
      @appliance_image = "https://www.ikea.com/us/en/images/products/medelniva-over-the-range-microwave-stainless-steel__0852294_pe780009_s5.jpg?f=s"
    end

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
    
    if the_appliance.appliance_type.in?(['Furnace','Water Heater','Air Conditioner'])
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
    
    if the_appliance.appliance_type.in?(['Furnace','Water Heater','Air Conditioner'])
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

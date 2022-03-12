class DashboardController < ApplicationController

  def index 
    if @current_user.houses.at(0) == nil 
      render({ :template => "homepage/new_user.html.erb"})
    else
      @primary_residence = @current_user.houses.where({ :primary_residence => "Yes" }).at(0)

      matching_appliances = @primary_residence.appliances.all
      @list_of_appliances = matching_appliances.order({ :category => :desc }) 

      matching_projects = @primary_residence.projects.all
      @list_of_projects = matching_projects.order({ :created_at => :desc })

      matching_contacts = @primary_residence.owner.contacts.all
      @list_of_contacts = matching_contacts.order({ :created_at => :desc })
      
      primary_house_address = @primary_residence.street_address + @primary_residence.city + @primary_residence.state
      gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{primary_house_address}&key=#{ENV.fetch("GMAPS_KEY")}"
      raw_gmaps_data = open(gmaps_url).read
      parsed_gmaps = JSON.parse(raw_gmaps_data)
      lat = parsed_gmaps.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat")
      lon = parsed_gmaps.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng")

      dsky_url = "https://api.darksky.net/forecast/#{ENV.fetch("DARK_SKY_KEY")}/#{lat},#{lon}"
      dsky_data = open(dsky_url).read
      @current_temp = JSON.parse(dsky_data).fetch("currently").fetch("temperature")

      if @current_temp < -20
        @humidity_level = "15%-20%"
      elsif @current_temp.between?(-20,0)
        @humidity_level = "20%-30%"
      elsif @current_temp.between?(0,25)
        @humidity_level = "30%-40%"
      elsif @current_temp.between?(25,50)
        @humidity_level = "Max. 40%"
      elsif @current_temp > 50
        @humidity_level = "Max. 45%"
      end

      @street_view_image = "https://maps.googleapis.com/maps/api/streetview?size=300x300&location=#{primary_house_address}&key=#{ENV.fetch("CB_GMAPS_KEY")}"

      render({ :template => "homepage/user_dashboard.html.erb"})
    end
  end

  def humidity_text 
    twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
    twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
    twilio_sending_number = ENV.fetch("TWILIO_SENDING_PHONE_NUMBER")

    twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    message = twilio_client.messages.
      create(
        :from => twilio_sending_number,
        :to => "+18473452223", # Put your own phone number here if you want to see it in action
        :body => "It's going to rain today — take an umbrella!",
        :send_at => Time.new(2022, 03, 12, 15, 54, 30),
        :schedule_type => "fixed"
      )
    
    puts message.sid

    #twilio_client.api.account.messages.create(sms_parameters)

    redirect_to("/")
  end
end
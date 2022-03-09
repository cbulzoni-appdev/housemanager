class DashboardController < ApplicationController

  def index 
    @primary_residence = @current_user.houses.where({ :primary_residence => "Yes" }).at(0)

    matching_appliances = @primary_residence.appliances.all
    @list_of_appliances = matching_appliances.order({ :created_at => :desc }) 
    
    primary_house_address = @primary_residence.street_address + @primary_residence.city + @primary_residence.state
    gmaps_url = "https://maps.googleapis.com/maps/api/geocode/json?address=#{primary_house_address}&key=#{ENV.fetch("GMAPS_KEY")}"
    raw_gmaps_data = open(gmaps_url).read
    parsed_gmaps = JSON.parse(raw_gmaps_data)
    lat = parsed_gmaps.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lat")
    lon = parsed_gmaps.fetch("results").at(0).fetch("geometry").fetch("location").fetch("lng")

    dsky_url = "https://api.darksky.net/forecast/#{ENV.fetch("DARK_SKY_KEY")}/#{lat},#{lon}"
    dsky_data = open(dsky_url).read
    @current_temp = JSON.parse(dsky_data).fetch("currently").fetch("temperature")

    render({ :template => "homepage/user_dashboard.html.erb"})
  end


end
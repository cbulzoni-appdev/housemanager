class DashboardController < ApplicationController

  def index 
    if @current_user.houses.at(0) == nil 
      render({ :template => "homepage/new_user.html.erb"})
    else
      @primary_residence = @current_user.houses.where({ :primary_residence => "Yes" }).at(0)

      matching_appliances = @primary_residence.appliances.all
      @list_of_appliances = matching_appliances.order({ :category => :desc })

      matching_projects = @primary_residence.projects.all
      @list_of_projects = matching_projects.order({ :status => :desc, :priority => :asc, :created_at => :asc })

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

      @total_cost_nys_high_projects = @current_user.projects.where({ :status => "Not Yet Started", :priority => "1-High"}).sum(:estimated_cost)
      @total_cost_nys_med_projects = @current_user.projects.where({ :status => "Not Yet Started", :priority => "2-Medium"}).sum(:estimated_cost)
      @total_cost_nys_low_projects = @current_user.projects.where({ :status => "Not Yet Started", :priority => "3-Low"}).sum(:estimated_cost)
      @total_cost_ip_high_projects = @current_user.projects.where({ :status => "In Progress", :priority => "1-High"}).sum(:estimated_cost)
      @total_cost_ip_med_projects = @current_user.projects.where({ :status => "In Progress", :priority => "2-Medium"}).sum(:estimated_cost)
      @total_cost_ip_low_projects = @current_user.projects.where({ :status => "In Progress", :priority => "3-Low"}).sum(:estimated_cost)
      @total_cost_comp_high_projects = @current_user.projects.where({ :status => "Completed", :priority => "1-High"}).sum(:estimated_cost)
      @total_cost_comp_med_projects = @current_user.projects.where({ :status => "Completed", :priority => "2-Medium"}).sum(:estimated_cost)
      @total_cost_comp_low_projects = @current_user.projects.where({ :status => "Completed", :priority => "3-Low"}).sum(:estimated_cost)

      @total_cost_nys_projects = @current_user.projects.where({ :status => "Not Yet Started"}).sum(:estimated_cost)
      @total_cost_ip_projects = @current_user.projects.where({ :status => "In Progress"}).sum(:estimated_cost)
      @total_cost_comp_projects = @current_user.projects.where({ :status => "Completed"}).sum(:estimated_cost)

      @total_cost_high_projects = @current_user.projects.where({ :priority => "1-High"}).sum(:estimated_cost)
      @total_cost_med_projects = @current_user.projects.where({ :priority => "2-Medium"}).sum(:estimated_cost)
      @total_cost_low_projects = @current_user.projects.where({ :priority => "3-Low"}).sum(:estimated_cost)

      @total_cost_projects = @current_user.projects.sum(:estimated_cost)


      render({ :template => "homepage/user_dashboard.html.erb"})
    end
  end
end
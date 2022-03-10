class HousesController < ApplicationController
  def index
    matching_houses = @current_user.houses.all

    @list_of_houses = matching_houses.order({ :created_at => :desc })

    render({ :template => "houses/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_houses = House.where({ :id => the_id })

    @the_house = matching_houses.at(0)

    render({ :template => "houses/show.html.erb" })
  end

  def create
    the_house = House.new
    the_house.street_address = params.fetch("query_street_address")
    the_house.city = params.fetch("query_city")
    the_house.state = params.fetch("query_state")
    the_house.zip_code = params.fetch("query_zip_code")
    the_house.purchase_date = params.fetch("query_purchase_date")
    the_house.owner_id = @current_user.id
    the_house.primary_residence = params.fetch("query_primary_residence")

    if the_house.valid?
      the_house.save
      redirect_to("/houses", { :notice => "House created successfully." })
    else
      redirect_to("/houses", { :alert => the_house.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_house = House.where({ :id => the_id }).at(0)

    the_house.street_address = params.fetch("query_street_address")
    the_house.city = params.fetch("query_city")
    the_house.state = params.fetch("query_state")
    the_house.zip_code = params.fetch("query_zip_code")
    the_house.purchase_date = params.fetch("query_purchase_date")
    the_house.owner_id = @current_user.id
    the_house.primary_residence = params.fetch("query_primary_residence")

    if the_house.valid?
      the_house.save
      redirect_to("/houses/#{the_house.id}", { :notice => "House updated successfully."} )
    else
      redirect_to("/houses/#{the_house.id}", { :alert => the_house.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_house = House.where({ :id => the_id }).at(0)

    the_house.destroy

    redirect_to("/houses", { :notice => "House deleted successfully."} )
  end
end

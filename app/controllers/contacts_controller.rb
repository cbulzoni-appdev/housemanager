class ContactsController < ApplicationController
  def index
    matching_contacts = @current_user.contacts.all

    @list_of_contacts = matching_contacts.order({ :created_at => :desc })

    render({ :template => "contacts/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_contacts = Contact.where({ :id => the_id })

    @the_contact = matching_contacts.at(0)

    render({ :template => "contacts/show.html.erb" })
  end

  def create
    the_contact = Contact.new
    the_contact.company_name = params.fetch("query_company_name")
    the_contact.contact_name = params.fetch("query_contact_name")
    the_contact.contact_type = params.fetch("query_contact_type")
    the_contact.email = params.fetch("query_email")
    the_contact.phone_number = params.fetch("query_phone_number")
    the_contact.owner_id = @current_user.id

    if the_contact.valid?
      the_contact.save
      redirect_to("/contacts", { :notice => "Contact created successfully." })
    else
      redirect_to("/contacts", { :alert => the_contact.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_contact = Contact.where({ :id => the_id }).at(0)

    the_contact.company_name = params.fetch("query_company_name")
    the_contact.contact_name = params.fetch("query_contact_name")
    the_contact.contact_type = params.fetch("query_contact_type")
    the_contact.email = params.fetch("query_email")
    the_contact.phone_number = params.fetch("query_phone_number")
    the_contact.owner_id = @current_user.id

    if the_contact.valid?
      the_contact.save
      redirect_to("/contacts/#{the_contact.id}", { :notice => "Contact updated successfully."} )
    else
      redirect_to("/contacts/#{the_contact.id}", { :alert => the_contact.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_contact = Contact.where({ :id => the_id }).at(0)

    the_contact.destroy

    redirect_to("/contacts", { :notice => "Contact deleted successfully."} )
  end
end

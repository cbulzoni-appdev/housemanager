class ContactsController < ApplicationController
  def index
    matching_contacts = @current_user.contacts.all

    @q = matching_contacts.order({ :created_at => :desc }).ransack(params[:q])

    @list_of_contacts = @q.result

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

  def send_text
    current_user_phone_number = "+1#{@current_user.phone_number.gsub("-","").gsub("(","").gsub(")","")}"
    contact_phone_number = "+1#{Contact.where({ :id => params.fetch("path_id")}).at(0).phone_number.gsub("-","").gsub("(","").gsub(")","")}"
    twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
    twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
    twilio_sending_number = ENV.fetch("TWILIO_SENDING_PHONE_NUMBER")

    # Create an instance of the Twilio Client and authenticate with your API key
    twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    # Craft your SMS as a Hash with three keys
    sms_parameters = {
      :from => "+18473452223",
      :to => "+13107019556", # Put your own phone number here if you want to see it in action
      :body => params.fetch("query_message")
    }

    # Send your SMS!
    twilio_client.api.account.messages.create(sms_parameters)

    redirect_to("/contacts")
  end

  def send_email

    the_id = params.fetch("path_id")
    the_contact = Contact.where({ :id => the_id }).at(0)
    
    # Retrieve your credentials from secure storage
    mg_api_key = ENV.fetch("MAILGUN_API_KEY")
    mg_sending_domain = ENV.fetch("MAILGUN_SENDING_DOMAIN")

    # Create an instance of the Mailgun Client and authenticate with your API key
    mg_client = Mailgun::Client.new(mg_api_key)

    # Craft your email as a Hash with these four keys
    email_parameters =  { 
      :from => @current_user.email,
      :to => the_contact.email,  # Put your own email address here if you want to see it in action
      :subject => params.fetch("query_subject"),
      :text => params.fetch("query_message")
    }

    # Send your email!
    mg_client.send_message(mg_sending_domain, email_parameters)

    redirect_to("/contacts")
  end

  def send_email

    the_id = params.fetch("path_id")
    the_contact = Contact.where({ :id => the_id }).at(0)
    
    # Retrieve your credentials from secure storage
    mg_api_key = ENV.fetch("MAILGUN_API_KEY")
    mg_sending_domain = ENV.fetch("MAILGUN_SENDING_DOMAIN")

    # Create an instance of the Mailgun Client and authenticate with your API key
    mg_client = Mailgun::Client.new(mg_api_key)

    # Craft your email as a Hash with these four keys
    email_parameters =  { 
      :from => @current_user.email,
      :to => the_contact.email,  # Put your own email address here if you want to see it in action
      :subject => params.fetch("query_subject"),
      :text => params.fetch("query_message")
    }

    # Send your email!
    mg_client.send_message(mg_sending_domain, email_parameters)

    redirect_to("/contacts")
  end
end

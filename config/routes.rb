Rails.application.routes.draw do

  get("/", { :controller => "dashboard", :action => "index" })

  # Routes for the Contact resource:

  # CREATE
  post("/insert_contact", { :controller => "contacts", :action => "create" })
          
  # READ
  get("/contacts", { :controller => "contacts", :action => "index" })
  
  get("/contacts/:path_id", { :controller => "contacts", :action => "show" })
  
  # UPDATE
  
  post("/modify_contact/:path_id", { :controller => "contacts", :action => "update" })
  
  # DELETE
  get("/delete_contact/:path_id", { :controller => "contacts", :action => "destroy" })

  # SEND TEXT
  post("send_contact_text/:path_id", { :controller => "contacts", :action => "send_text" })

  # SEND EMAIL
  post("send_contact_email/:path_id", { :controller => "contacts", :action => "send_email" })

  #------------------------------

  # Routes for the Project resource:

  # CREATE
  post("/insert_project", { :controller => "projects", :action => "create" })
          
  # READ
  get("/projects", { :controller => "projects", :action => "index" })
  
  get("/projects/:path_id", { :controller => "projects", :action => "show" })
  
  # UPDATE
  
  post("/modify_project/:path_id", { :controller => "projects", :action => "update" })
  
  # DELETE
  get("/delete_project/:path_id", { :controller => "projects", :action => "destroy" })

  # UPDATE STATUS

  get("/update_project_status/:path_id/:path_current_status/:path_new_status", { :controller => "projects", :action => "update_status"})

  #------------------------------

  # Routes for the User account:

  # SIGN UP FORM
  get("/user_sign_up", { :controller => "user_authentication", :action => "sign_up_form" })        
  # CREATE RECORD
  post("/insert_user", { :controller => "user_authentication", :action => "create"  })
      
  # EDIT PROFILE FORM        
  get("/edit_user_profile", { :controller => "user_authentication", :action => "edit_profile_form" })       
  # UPDATE RECORD
  post("/modify_user", { :controller => "user_authentication", :action => "update" })
  
  # DELETE RECORD
  get("/cancel_user_account", { :controller => "user_authentication", :action => "destroy" })

  # ------------------------------

  # SIGN IN FORM
  get("/user_sign_in", { :controller => "user_authentication", :action => "sign_in_form" })
  # AUTHENTICATE AND STORE COOKIE
  post("/user_verify_credentials", { :controller => "user_authentication", :action => "create_cookie" })
  
  # SIGN OUT        
  get("/user_sign_out", { :controller => "user_authentication", :action => "destroy_cookies" })
             
  #------------------------------

  # Routes for the House resource:

  # CREATE
  post("/insert_house", { :controller => "houses", :action => "create" })
          
  # READ
  get("/houses", { :controller => "houses", :action => "index" })
  
  get("/houses/:path_id", { :controller => "houses", :action => "show" })
  
  # UPDATE
  
  post("/modify_house/:path_id", { :controller => "houses", :action => "update" })
  
  # DELETE
  get("/delete_house/:path_id", { :controller => "houses", :action => "destroy" })

  #------------------------------

  # Routes for the Appliance resource:

  # CREATE
  post("/insert_appliance", { :controller => "appliances", :action => "create" })
          
  # READ
  get("/appliances", { :controller => "appliances", :action => "index" })
  
  get("/appliances/:path_id", { :controller => "appliances", :action => "show" })
  
  # UPDATE
  
  post("/modify_appliance/:path_id", { :controller => "appliances", :action => "update" })
  
  # DELETE
  get("/delete_appliance/:path_id", { :controller => "appliances", :action => "destroy" })

  #------------------------------

end

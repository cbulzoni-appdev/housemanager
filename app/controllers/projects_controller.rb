class ProjectsController < ApplicationController
  def index
    matching_projects = Project.all

    @list_of_projects = matching_projects.order({ :created_at => :desc })

    render({ :template => "projects/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_projects = Project.where({ :id => the_id })

    @the_project = matching_projects.at(0)

    render({ :template => "projects/show.html.erb" })
  end

  def create
    the_project = Project.new
    the_project.description = params.fetch("query_description")
    the_project.status = params.fetch("query_status")
    the_project.date_started = params.fetch("query_date_started")
    the_project.date_completed = params.fetch("query_date_completed")
    the_project.notes = params.fetch("query_notes")
    the_project.house_id = params.fetch("query_house_id")
    the_project.contact_id = params.fetch("query_contact_id")

    if the_project.valid?
      the_project.save
      redirect_to("/projects", { :notice => "Project created successfully." })
    else
      redirect_to("/projects", { :alert => the_project.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_project = Project.where({ :id => the_id }).at(0)

    the_project.description = params.fetch("query_description")
    the_project.status = params.fetch("query_status")
    the_project.date_started = params.fetch("query_date_started")
    the_project.date_completed = params.fetch("query_date_completed")
    the_project.notes = params.fetch("query_notes")
    the_project.house_id = params.fetch("query_house_id")
    the_project.contact_id = params.fetch("query_contact_id")

    if the_project.valid?
      the_project.save
      redirect_to("/projects/#{the_project.id}", { :notice => "Project updated successfully."} )
    else
      redirect_to("/projects/#{the_project.id}", { :alert => the_project.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_project = Project.where({ :id => the_id }).at(0)

    the_project.destroy

    redirect_to("/projects", { :notice => "Project deleted successfully."} )
  end
end

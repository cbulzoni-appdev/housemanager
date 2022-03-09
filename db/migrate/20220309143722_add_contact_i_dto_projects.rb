class AddContactIDtoProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :contact_id, :integer
  end
end

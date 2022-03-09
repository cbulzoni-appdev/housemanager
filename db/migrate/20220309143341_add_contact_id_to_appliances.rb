class AddContactIdToAppliances < ActiveRecord::Migration[6.0]
  def change
    add_column :appliances, :contact_id, :integer
  end
end

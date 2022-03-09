class CreateContacts < ActiveRecord::Migration[6.0]
  def change
    create_table :contacts do |t|
      t.string :company_name
      t.string :contact_name
      t.string :contact_type
      t.string :email
      t.string :phone_number
      t.integer :owner_id

      t.timestamps
    end
  end
end

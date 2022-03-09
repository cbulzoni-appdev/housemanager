class CreateHouses < ActiveRecord::Migration[6.0]
  def change
    create_table :houses do |t|
      t.string :street_address
      t.string :city
      t.string :state
      t.string :zip_code
      t.date :purchase_date
      t.integer :owner_id
      t.string :primary_residence

      t.timestamps
    end
  end
end

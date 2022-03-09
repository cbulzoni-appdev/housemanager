class CreateAppliances < ActiveRecord::Migration[6.0]
  def change
    create_table :appliances do |t|
      t.string :category
      t.string :appliance_type
      t.string :make
      t.string :model
      t.integer :year
      t.date :last_serviced
      t.date :service_due
      t.text :notes
      t.integer :house_id

      t.timestamps
    end
  end
end

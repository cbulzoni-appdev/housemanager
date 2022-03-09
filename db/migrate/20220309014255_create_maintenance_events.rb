class CreateMaintenanceEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :maintenance_events do |t|
      t.text :description
      t.date :maintenance_date
      t.integer :house_id

      t.timestamps
    end
  end
end

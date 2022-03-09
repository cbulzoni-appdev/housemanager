class CreateProjects < ActiveRecord::Migration[6.0]
  def change
    create_table :projects do |t|
      t.text :description
      t.string :status
      t.date :date_started
      t.date :date_completed
      t.text :notes
      t.integer :house_id

      t.timestamps
    end
  end
end

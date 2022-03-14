class AddPriorityAndEstimatedSpendToProjects < ActiveRecord::Migration[6.0]
  def change
    add_column :projects, :priority, :string
    add_column :projects, :estimated_spend, :float
  end
end

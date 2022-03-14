class RenameProjectsSpendToCost < ActiveRecord::Migration[6.0]
  def change
    rename_column :projects, :estimated_spend, :estimated_cost
  end
end

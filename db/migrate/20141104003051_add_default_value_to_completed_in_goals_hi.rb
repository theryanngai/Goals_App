class AddDefaultValueToCompletedInGoalsHi < ActiveRecord::Migration
  def change
    change_column :goals, :completed, :boolean, null: false, default: false
  end
end

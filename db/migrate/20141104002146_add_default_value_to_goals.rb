class AddDefaultValueToGoals < ActiveRecord::Migration
  def change
    change_column :goals, :private?, :boolean, null: false, default: false
  end
end

class AddPrivatetoGoals < ActiveRecord::Migration
  def change
    add_column :goals, :private?, :boolean
    change_column :goals, :private?, :boolean, null: false
  end
end

class ModifyPrivateName2 < ActiveRecord::Migration
  def change
    remove_column :goals, :private
    add_column :goals, :restricted, :boolean, null: false, default: false
  end
end

class ModifyPrivateName < ActiveRecord::Migration
  def change
    remove_column :goals, :private?
    add_column :goals, :private, :boolean, null: false, default: false
  end
end

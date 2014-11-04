class CreateGoals < ActiveRecord::Migration
  def change
    create_table :goals do |t|
      t.integer :user_id, null: false 
      t.string :title, null: false
      t.string :body, null: false
      t.boolean :completed, null: false

      t.timestamps
    end
    
    add_index :goals, :user_id
  end
end

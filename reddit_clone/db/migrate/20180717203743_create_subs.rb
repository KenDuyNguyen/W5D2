class CreateSubs < ActiveRecord::Migration[5.1]
  def change
    create_table :subs do |t|
      t.string :title, null: false 
      t.string :description, null: false 
      t.integer :mod_id, null: false
      
      t.timestamps
    end
    
    add_index :subs, :title
    add_index :subs, :mod_id
  end
end

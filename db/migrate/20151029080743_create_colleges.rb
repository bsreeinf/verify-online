class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.references :user
      t.string :name
      t.string :address
      t.integer :verification_amount
      t.string :logo
      
      t.timestamps null: false
    end
    add_index :colleges, [:user_id]
  end
end

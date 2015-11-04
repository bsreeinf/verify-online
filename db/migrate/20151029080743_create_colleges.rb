class CreateColleges < ActiveRecord::Migration
  def change
    create_table :colleges do |t|
      t.integer :admin_user_id
      t.string :name
      t.string :address

      t.timestamps null: false
    end
  end
end

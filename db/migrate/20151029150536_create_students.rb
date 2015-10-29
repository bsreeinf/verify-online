class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :hallticket_no


      t.timestamps null: false
    end
  end
end

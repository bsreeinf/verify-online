class CreateVerificationRequests < ActiveRecord::Migration
  def change
    create_table :verification_requests do |t|
      t.references :student
      t.references :college
      t.references :verification_status
      t.string :name
      t.string :hallticket_no
      t.string :document_link
      t.integer :amount
      t.integer :service_tax

      

      t.string :course              
      t.string :type_of_studies    
      t.string :course_duration		
      t.string :remarks				
      t.string :class_awarded		



      t.timestamps null: false
    end
  end
end
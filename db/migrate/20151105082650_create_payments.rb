class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.references :verification_request
      t.references :payment_status
      t.string :transaction_code
      t.float :amount
      t.string :mode_of_payment	

      t.timestamps null: false
      
    end
  end
end

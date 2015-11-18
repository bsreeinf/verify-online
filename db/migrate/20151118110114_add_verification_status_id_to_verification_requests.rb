class AddVerificationStatusIdToVerificationRequests < ActiveRecord::Migration
  def change
  	add_column :verification_requests, :verification_status_id, :integer, default: 1
  	
  end
end

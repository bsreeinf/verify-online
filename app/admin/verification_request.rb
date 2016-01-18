ActiveAdmin.register VerificationRequest do
permit_params :student_id, :college_id, :name, :hallticket_no, :document_link
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end

index :title => "Verification Requests" do |verification_request|
	selectable_column
       column "Sl. no.", :id
       column "Verification ID", :verification_token
       column "Name", :name
       column "Hallticket no", :hallticket_no
       column "Requested on", :created_at

       column "Document" do |verification_request|
		   raw "<a href='#{verification_request.document_link }' target='blank'>download</a>"
	   end

       column "College" do |verification_request|
		   verification_request.college.name
	   end
	   column "Amount", :amount
       column "Status" do |verification_request|
		   verification_request.verification_status.description
	   end

	   column "Request Date" do |verification_request|
	   		if verification_request.verification_status_id !=1
	   			raw "#{local_time(verification_request.created_at + 330.minutes, '%d/%m/%Y %l:%M%p')}"
	   		end
	   end

	   column "Last updated" do |verification_request|
	   		if verification_request.verification_status_id !=1
	   			raw "#{local_time(verification_request.updated_at + 330.minutes, '%d/%m/%Y %l:%M%p')}"
	   		end
	   end

	   column "Report" do |verification_request|
		   raw "<a href='/final_report_user.pdf?verification_id=#{verification_request.id}' target='blank'>download</a>"
	   end
	         
	  actions
	end

 end

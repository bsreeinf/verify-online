ActiveAdmin.register User do

# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :email,:phone, :password, :password_confirmation, :address, :city, :pincode, :state, :country
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if resource.something?
#   permitted
# end
	form do |f|
	    f.inputs "User Details" do
			f.input :name
			f.input :email
			f.input :password
			f.input :password_confirmation
			f.input :phone
			f.input :address
			f.input :city
			f.input :pincode
			f.input :state
			f.input :country
	    end
	    f.actions
  	end

end

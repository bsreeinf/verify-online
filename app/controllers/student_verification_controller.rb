class StudentVerificationController < ApplicationController
	include StudentVerificationHelper

	before_action :logged_in_user, only: [:index, :status, :history ]
	before_action :set_s3_direct_post, only: [:index]
	
	

	def index
		@colleges = College.all
		if(params.has_key?(:college_id))
        	@college_id = params[:college_id]
        end
        @college = College.first
		render "apply"
	end

	def status
		# store variables in session or flash between two actions
		# flash[:var] = ["hello", "goodbye"]
		@verifications = VerificationRequest.all.page params[:page]
		
	end

	def history
		# @hello = flash[:var].first
		# puts @hello
		@payments = Payment.all.page params[:page]
		
	end


	def send_to_ccavenue		

		# orderID = # to be generated to_s

	 #    amount = params[:amount].to_s

	 #    redirectURL = "https://www.verifyonline.herokuapp.com/student_verification/payment_confirm"

	 #    checksum = getChecksum(CCAVENUE_MERCHANT_ID, orderID, amount, redirectURL, CCAVENUE_WORKING_KEY)

	 #    @ccaRequest = 

	 #      "Merchant_Id="+CCAVENUE_MERCHANT_ID+"&"+

	 #      "Amount="+amount+"&"+

	 #      "Order_Id="+orderID+"&"+

	 #      "Redirect_Url="+redirectURL+"&"+

	 #      "billing_cust_name="+current_user.name+"&"+

	 #      "billing_cust_address="+current_user.address+"&"+

	 #      "billing_cust_city="+current_user.city+"&"+

	 #      "billing_zip_code="+current_user.pincode.to_s+"&"+

	 #      "billing_cust_state="+current_user.state+"&"+

	 #      "billing_cust_country="+current_user.country+"&"+

	 #      "billing_cust_email="+current_user.email+"&"+

	 #      "billing_cust_tel="+current_user.phone+"&"+

	 #      "Checksum="+checksum.to_s


	 #      @encRequest=encrypt_string(@ccaRequest)


	      # modify the database
		
	end

	# def payment_confirm  
 #        @encResponse = params[:encResponse]

	#     @checksum = false

	#     @authDesc = false

	#     @p = nil

	#     @ccaResponse = nil

	#     if (params[:encResponse])

	#             if @encResponse
	        		
	#         		@ccaResponse = decrypt_string(@encRequest)

	#         		@p = Rack::Utils.parse_nested_query @ccaResponse

	# 		        if (!@p.nil? && @p["Merchant_Id"] && @p["Order_Id"] && @p["Amount"] && @p["AuthDesc"] && @p["Checksum"])

	# 		          @checksum = verifyChecksum(@p["Merchant_Id"], @p["Order_Id"], @p["Amount"], @p["AuthDesc"], CCAVENUE_WORKING_KEY, @p["Checksum"])

	# 		          @authDesc = @p["AuthDesc"].eql?("Y") ? true : false

	# 		        end

	#       		end

	# 			if @checksum && @authDesc 

	# 				# modify db accordingly	


	# 				# https://www.verifyonline.herokuapp.com/student_verification/payment_confirm?trans_ids=2342,2354,25245
	# 				# trans_ids = params[:trans_ids].split(',')
	# 				# trans_ids.each do |trans_id|
	# 			    #   
	# 			    # end

	# 				# transaction = Transaction.find(@p["Order_Id"])

	# 				# transaction.payment_confirmed = true

	# 				# transaction.save!

	# 				# message = current_buyer.user.name + "! Thank you for your order! It will soon be at your doorsteps!" 

	# 				# redirect_to root_path, :flash => {:success => message}

	# 			else

	# 		        if !@authDesc

	# 		          # message = current_user.user.name + "! Your bank did not authorize the transaction." 

	# 		          # redirect_to root_path, :flash => {:error => message}

	# 		        else

	# 		          # message = current_buyer.user.name + "! Oops! There was some error in retrieving your transaction confirmation. Please drop us an email at dealbuddie@dealbuddie.com for order confirmation." 

	# 		          # redirect_to root_path, :flash => {:error => message}

	# 		        end

	#       		end

	#     else

	# 		# message = current_buyer.user.name + "! Oops! Something went wrong while processing your request. Please go to Settings > My Orders page, and click on "Pay Now" button to finish your transaction." 

	# 		# redirect_to root_path, :flash => {:success => message}

	#     end
	#     # redirect to student verification status page 
 	
 #    end




	private
		

		def set_s3_direct_post
			@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
		end

end

class StudentVerificationController < ApplicationController
	include StudentVerificationHelper
	helper_method :sort_column, :sort_direction

	before_action :logged_in_user, only: [:apply, :status, :history, :report ]
	before_action :set_s3_direct_post, only: [:apply]
	
	def apply
        if request.post?
        	puts "post request"
			redirect_to payment_path
		else
			@colleges = College.all
			if(params.has_key?(:college_id))
	        	@college_id = params[:college_id]
	        end
	        @college = College.first 
	        render 'apply'
		end
	end

	def add_verification
		@verification_request = VerificationRequest.new(verification_params)
		@verification_request.amount = College.where(:id => @verification_request.college_id).pluck(:verification_amount)[0]
		@verification_request.verification_status_id = 1
		@verification_request.service_tax = (@verification_request.amount * 0.05).round(2)

	    # respond_to do |format|
	      if @verification_request.save
	        # format.html { redirect_to @verification_request, notice: 'Student was successfully created.' }
	        render json: @verification_request.to_json
	        # format.json { render :show, status: :created, location: @verification_request }
	      else
	        # format.html { render :new }
	        # format.json { render json: @verification_request.errors, status: :unprocessable_entity }
	        render json: @verification_request.errors
	      end
	    # end
	end

	def update_multiple

	end

	def report
	    @disable_header_footer = true
	    @verification_stub = VerificationRequest.find_by(id: params[:verification_id])
	    @college = College.find(@verification_stub.college_id)
	    @user = User.find(current_user.id)
	    respond_to do |format|
	      format.html
	      format.pdf do
	        html = render_to_string(template: "student_verification/report.html.erb") 
	        pdf = WickedPdf.new.pdf_from_string(html) 
	        send_data(pdf, 
	          :filename    => "report_#{@verification_stub.name.gsub(/\s+/, "")}_#{@verification_stub.hallticket_no}.pdf", 
	          :disposition => 'attachment') 

	        # render  pdf: "report_#{@verification_stub.name.gsub(/\s+/, "")}_#{@verification_stub.hallticket_no}", 
	        #         template: "college_verification/report.html.erb"
	      end
	    end
	  end

	def status
		# store variables in session or flash between two actions
		# flash[:var] = ["hello", "goodbye"]
		# @verifications = VerificationRequest.all.where(
		# 	"student_id = ?",current_user.id
		# 	).search(params[:search]).order(
		# 		sort_column + " COLLATE NOCASE " + sort_direction
		# 		).paginate(page: params[:page],:per_page => 10)
		if params.has_key?(:search_tag)
	      @verifications =  VerificationRequest.all.where(
	        "student_id = ? AND (hallticket_no LIKE ? OR name LIKE ?)", 
	          current_user.id, 
	          "%#{params[:search_tag]}%",
	          "%#{params[:search_tag]}%"
	        ).paginate(page: params[:page],:per_page => 10)
	    else  
	      @verifications =  VerificationRequest.all.where(
	        "student_id = ?", 
	          current_user.id
	        ).paginate(page: params[:page],:per_page => 10)
	    end
		
	end

	def history
		# @hello = flash[:var].first
		# puts @hello
		@payments = Payment.all.paginate(page: params[:page],:per_page => 10)
		
	end

	def update_db





		# respond_to do |format|
		# 		format.html { redirect_to payment_path	}
	 #      		format.json { }
	 #      		format.js {render js: "window.location = '#{payment_path}';"}

		# 	end

		
		# puts "hello world"

		# # puts JSON.parse(params)
	 #    params[:ids].each do |n|
	 #    	puts n
	 #    end

	 #   	k= params[:ids].count
	    
	 #    k.times do |n|

	 #    	puts n
	    	 

	 #    	# @vrequest = VerificationRequest.new(params[:verification_requests][n])
	 #     #  	@vrequest.save
	 #    end
	    
	    
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




	 # add this in html.erb
		# <form id="payment_redirect" method="post" name="redirect" action="http://www.ccavenue.com/shopzone/cc_details.jsp">

		# <input type=hidden name=encRequest value=<%=@encRequest%>>

		# <input type=hidden name=Merchant_Id value=<%=CCAVENUE_MERCHANT_ID%>>

		# </form>


		# <script type="text/javascript">

		# $(function() {

		#   $(’#redirect’).submit();

		# });

		# </script> 


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

		def verification_params
	      params.require(:verification_request).permit(:student_id, :college_id, :name, :hallticket_no, :document_link)
	    end

		def set_s3_direct_post
			@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
		end


  
		def sort_column
			VerificationRequest.column_names.include?(params[:sort]) ? params[:sort] : "name"
		end

		def sort_direction
			%w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
		end

end

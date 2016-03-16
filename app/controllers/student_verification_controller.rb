class StudentVerificationController < ApplicationController
	include StudentVerificationHelper
	helper_method :sort_column, :sort_direction

	before_action :logged_in_user, only: [:apply, :status, :history]
	before_action :set_s3_direct_post, only: [:apply]
	require 'httparty'
	
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
		@college_ver = College.where(:id => @verification_request.college_id).first
		@verification_request.amount = @college_ver.verification_amount
		@verification_request.verification_status_id = 1
		@verification_request.service_tax = (@verification_request.amount + 114.5).round(2)

	    # respond_to do |format|
	      if @verification_request.save
	        # format.html { redirect_to @verification_request, notice: 'Student was successfully created.' }
	        url = HTTParty.get("http://api.mvaayoo.com/mvaayooapi/MessageCompose?user=#{ENV['MVAAYOO_USER']}:#{ENV['MVAAYOO_PASSWORD']}&senderID=TEST%20SMS&receipientno=#{@college_ver.user.phone}&msgtxt=New verification for #{@college_ver.name}. Name: #{@verification_request.name}. Hallticket: #{@verification_request.hallticket_no}&state=4")
	        render json: @verification_request.to_json
	        # Mvaayoo.send_message "New verification for #{@college_ver.name}. Name: #{@verification_request.name}. Hallticket: #{@verification_request.hallticket_no}", @college_ver.user.phone
	        # format.json { render :show, status: :created, location: @verification_request }
	      else
	        # format.html { render :new }
	        # format.json { render json: @verification_request.errors, status: :unprocessable_entity }
	        render json: @verification_request.errors
	      end
	    # end
	end

	def report
	    @disable_header_footer = true
	    @verification_stub = VerificationRequest.find_by(id: params[:verification_id])
	    @college = College.find(@verification_stub.college_id)
	    @user = User.find_by(id: @verification_stub.user_id)
	    @client_ip = request.remote_ip
	    respond_to do |format|
	      format.pdf do
	        pdf = WickedPdf.new.pdf_from_string(
	          render_to_string(template: "report_data/report.html.erb"),
	          :footer => {right: "Powered by www.verifyonline.in"}
	        ) 
	        send_data(pdf, 
	          :filename    => "report_#{@verification_stub.name.gsub(/\s+/, "")}_#{@verification_stub.hallticket_no}.pdf", 
	          :disposition => 'attachment'
	        )

	        # render  pdf: "report_#{@verification_stub.name.gsub(/\s+/, "")}_#{@verification_stub.hallticket_no}", 
	        #         template: "college_verification/report.html.erb"
	      end
	    end
	end

	def status
		if params.has_key?(:search_tag)
	      @verifications =  VerificationRequest.all.where(
	        "user_id = ? AND (hallticket_no ILIKE ? OR name ILIKE ? OR verification_token ILIKE ?)", 
	          current_user.id, 
	          "%#{params[:search_tag]}%",
	          "%#{params[:search_tag]}%",
	          "%#{params[:search_tag]}%"
	        ).order('created_at DESC')
	      .paginate(page: params[:page],:per_page => 10)
	    else  
	      @verifications =  VerificationRequest.all.where(
	        "user_id = ?", 
	          current_user.id
	        ).order('created_at DESC')
	      .paginate(page: params[:page],:per_page => 10)
	    end
		
	end

	def history
		# @hello = flash[:var].first
		# puts @hello
		@payments = Payment.all.order('created_at DESC')
		.paginate(page: params[:page],:per_page => 10)
		
	end

	def proceed_to_pay
		verification_ids = JSON.parse(params['verification_ids']).to_h
		@result = HTTParty.post("https://www.instamojo.com/api/1.1/links/", 
		    :body => { 
		    	:title => 'Verify Online Payment', 
                :description => 'Hi, ', 
                :currency => 'INR', 
                :base_price => '100', 
                :redirect_url => "#{request.base_url}/payment_confirmation",
                :webhook_url => "#{request.base_url}/instamojo_webhook"
		    },
		    :headers => { 
		    	'X-Api-Key' => "#{ENV['INSTAMOJO_API_KEY']}",
				'X-Auth-Token' => "#{ENV['INSTAMOJO_AUTH_TOKEN']}"
			} 
		)
		VerificationRequest.where("id" => verification_ids).update_all(payment_slug: @result.parsed_response["link"]["slug"])
		# redirect_to @result.parsed_response["link"]["url"]
		data = []
		data.url = @result.parsed_response["link"]["url"]
		render json: data.to_json
	end

	def payment_confirmation 
		@payment_id = params['payment_id']
	end

	def instamojo_webhook
		puts "---- Webhook params start ----"
	    puts params.inpect
	    puts "---- Webhook params end ----"

	    @payment = Payment.new(instamojo_webhook_params)
		@payment.save
		VerificationRequest.where("slug" => params["offer_slug"]).update_all(payment_id: @payment.id)
	end

	private

		def verification_params
	     	params.require(:verification_request).permit(:user_id, :college_id, :name, :hallticket_no, :document_link)
	    end

	    def instamojo_webhook_params
	    	# params.permit(:variants, :buyer, :custom_fields, :buyer_name, :amount, :mac, :offer_title, :fees, :offer_slug, :buyer_phone, :payment_id, :quantity, :currency, :status, :unit_price)
	    	params.permit(:transaction_id, :buyer, :buyer_name, :amount, :mac, :offer_title, :fees, :buyer_phone, :currency, :status)
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

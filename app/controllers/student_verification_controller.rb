class StudentVerificationController < ApplicationController
	before_action :logged_in_user, only: [:index, :status, :history ]
	before_action :set_s3_direct_post
	
	def index
		@colleges = College.all
		if(params.has_key?(:college_id))
        	@college_id = params[:college_id]
        end
        @college = College.first
		render "apply"
	end

	def status
		render "status"
	end

	def history
		render "history"
	end

	private
		AWS_ACCESS_KEY_ID =        'AKIAILAV5TWW3Q4M4BGQ'
		AWS_SECRET_ACCESS_KEY =    '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'
		S3_BUCKET_NAME =                'verifyonline-documents'

		Aws.config.update({
		  region: 'ap-southeast-1',
		  credentials: Aws::Credentials.new(AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY),
		})

		S3_BUCKET = Aws::S3::Resource.new.bucket(S3_BUCKET_NAME)

		def set_s3_direct_post
			@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
		end
end

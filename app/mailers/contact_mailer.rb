class ContactMailer < ActionMailer::Base
	def contact_created(name,email,message)
		@name = name
		@email = email

		
		@message = message
		mail(
				to: "support@verifyonline.in",
				from: 'Verify online <support@verifyonline.in>',
				subject: "New Contact"
			)
	end
end 
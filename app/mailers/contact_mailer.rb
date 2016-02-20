class ContactMailer < ActionMailer::Base
	def contact_created(name,email,message)
		@name = name
		@email = email

		
		@message = message
		mail(
				to: "freelancetest29@gmail.com",
				from: 'Verify online <freelancetest29@gmail.com>',
				subject: "New Contact"
			)
	end
end 
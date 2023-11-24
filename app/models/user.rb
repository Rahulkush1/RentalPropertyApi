class User < ApplicationRecord
	has_secure_password
	rolify
	has_many :properties, dependent: :destroy
	has_many :appointments, dependent: :destroy
	# after_create :confirm_account
	accepts_nested_attributes_for :roles, allow_destroy: true
	
	def confirm_account
		email_token = JsonWebTokenService.encode({ email: self.email })
		ConfirmationMailer.confirm_mail(email_token).deliver_now
	end

	 def self.ransackable_attributes(auth_object = nil)
    	["activated", "confirmed_at", "created_at", "email", "firts_name", "id", "last_name", "password_digest", "updated_at"]
  	end
end
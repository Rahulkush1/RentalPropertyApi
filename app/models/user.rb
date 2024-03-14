class User < ApplicationRecord
	has_secure_password
	rolify
	has_many :properties, dependent: :destroy
	has_many :appointments, dependent: :destroy
	has_one :address, as: :addressable ,dependent: :destroy
	after_create :confirm_account
	accepts_nested_attributes_for :roles, allow_destroy: true
	accepts_nested_attributes_for :address, allow_destroy: true
	
	def confirm_account
		binding.pry
		email_token = JsonWebTokenService.encode({ email: self.email })
		ConfirmationMailer.confirm_mail(email_token).deliver_now
	end

	def self.ransackable_attributes(auth_object = nil)
    	["activated", "confirmed_at", "created_at", "email", "firts_name", "id", "last_name", "password_digest", "updated_at"]
  	end

	def self.from_omniauth(omniauth_params)
	provider = omniauth_params.provider
	uid = omniauth_params.uid

	user = User.find_or_initialize_by(provider:, uid:)
	binding.pry
	user.email = omniauth_params.info.email
	user.name = omniauth_params.info.name
	# user.image = omniauth_params.info.image
	user.save
	user
	end
end
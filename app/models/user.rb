class User < ApplicationRecord
	has_secure_password
	rolify
	  has_many :reviews
  	has_many :properties, through: :reviews
	# has_many :properties, dependent: :destroy
	has_many :appointments, dependent: :destroy
	has_many :payments, dependent: :destroy
	has_one :address, as: :addressable ,dependent: :destroy
	after_create :confirm_account, :customer
	accepts_nested_attributes_for :roles, allow_destroy: true
	accepts_nested_attributes_for :address, allow_destroy: true
	
	def confirm_account
		email_token = JsonWebTokenService.encode({ email: self.email })
		ConfirmationMailer.confirm_mail(email_token).deliver_now
	end

	def self.ransackable_attributes(auth_object = nil)
    	["activated", "confirmed_at", "created_at", "email", "firts_name", "id", "last_name", "password_digest", "updated_at"]
  	end

  	def customer
  	customer = Stripe::Customer.create({
      name: self.full_name,
      phone: self.phone_number, 
      email: self.email
    })
    self.update(customer_id: customer.id)
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

	def full_name
		self.first_name.capitalize + " " + self.last_name.capitalize
	end
end
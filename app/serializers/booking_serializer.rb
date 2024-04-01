class BookingSerializer
	include FastJsonapi::ObjectSerializer

	set_key_transform :underscore
	attributes :id

	attribute :user do |object|
		object&.user
	end

	attribute :property do |object| 
	object&.property
	end

	attribute :payment do |object| 
		PaymentSerializer.new(object.payment)
	end

end
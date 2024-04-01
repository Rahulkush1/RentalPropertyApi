class PaymentSerializer
	include FastJsonapi::ObjectSerializer

	set_key_transform :underscore
	attributes :id, :property_price, :total_price, :payment_status

	attribute :created_at do |object|
		object.created_at.strftime("%A, %B %d, %Y")
	end

end
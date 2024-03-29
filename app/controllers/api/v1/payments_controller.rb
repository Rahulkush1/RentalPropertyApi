class Api::V1::PaymentsController < ApplicationController
	# before_action :getPropertyId
	# before_action :createProduct
	# before_action :createPrice
  before_action :authenticate_user, :only => [:create, :complete]
	# def create_payment_intent

	# 	@property = Property.find(params[:property_id])
		# customer = Stripe::Customer.create({
    #   name: "#{current_user.firts_name} #{current_user.last_name}",
    #   phone: current_user.phone_number, 
    #   email: current_user.email
    # })
  #   amount = @property.price * 100
  #   currency = 'inr'
	# 	# payment_method = Stripe::PaymentMethod.create({
	# 	#   type: 'card',
	# 	#   card: {
	# 	#     number: '4242424242424242',
	# 	#     exp_month: 8,
	# 	#     exp_year: 2026,
	# 	#     cvc: '314',
	# 	#   },
	# 	# })
  #   intent = Stripe::PaymentIntent.create({
  #     amount: amount,
  #     currency: currency,	
  #     payment_method: 'pm_card_visa',
  #     use_stripe_sdk: true,
  #     customer: customer.id
  #   })


  #   confirm = Stripe::PaymentIntent.confirm(
	# 	  intent.id,
	# 	  {
	# 	    payment_method: 'pm_card_visa',
	# 	    return_url: 'https://www.example.com',
	# 	  },
	# 	)

  #   render json: { payment: confirm }
  #  end

	# def getPropertyId
	# 	@property = Property.find(params[:property_id])
	# end

	# def payment_confirmation
	# 	payment = Stripe::PaymentIntent.retrieve(params['payment_intent_id'])
	# 	render json: {payment: payment }
	# end

  # def createProduct
  #   product = Stripe::Product.create({
  #     name: @property.name,
  #   })
  # end

	# def createPrice
	# 	price = Stripe::Price.create({
	#     product: product.id,
	#     unit_amount: @property.price * 100,
	#     currency: 'inr'
	#   })
	# end

	def create
		amount = params[:data][:amount].to_i * 100
		customer_id = params[:data][:customer_id]
		@myPayment =  Stripe::PaymentIntent.create({
			amount: amount,
			currency: "inr",
			metadata: {
				company: "RentalProperty",
			},
			customer: customer_id
		});
		render json: {client_secret: @myPayment.client_secret, success: true}, status: 200

	end

	def complete
		binding.pry
		@payment_intent_id = params[:payment_intent]
		@payment = current_user.payments.new(payment_params)
		if @payment.save
			render json: PaymentSerializer.new(@payment).serialized_json, status: 201
		else
			 render json: { error: @payment.errors.full_messages }, status: :unprocessable_entity
		end
	end

	private

	def payment_params
		params.permit(:payment_intent_id, :paid_At, :payment_status)
	end

end
# pi_3OzZslSH6OcOxuhn1OuZXnIA
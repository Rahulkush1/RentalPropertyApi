class Api::V1::PaymentsController < ApplicationController
	# before_action :getPropertyId
	# before_action :createProduct
	# before_action :createPrice
  before_action :authenticate_user, :only => [:create_payment_intent]
	def create_payment_intent

		@property = Property.find(params[:property_id])
		customer = Stripe::Customer.create({
      name: "#{current_user.firts_name} #{current_user.last_name}",
      phone: current_user.phone_number, 
      email: current_user.email
    })
    amount = @property.price * 100
    currency = 'inr'
		# payment_method = Stripe::PaymentMethod.create({
		#   type: 'card',
		#   card: {
		#     number: '4242424242424242',
		#     exp_month: 8,
		#     exp_year: 2026,
		#     cvc: '314',
		#   },
		# })
    intent = Stripe::PaymentIntent.create({
      amount: amount,
      currency: currency,	
      payment_method: 'pm_card_visa',
      use_stripe_sdk: true,
      customer: customer.id
    })


    confirm = Stripe::PaymentIntent.confirm(
		  intent.id,
		  {
		    payment_method: 'pm_card_visa',
		    return_url: 'https://www.example.com',
		  },
		)

    render json: { payment: confirm }
   end

	def getPropertyId
		@property = Property.find(params[:property_id])
	end

	def payment_confirmation
		payment = Stripe::PaymentIntent.retrieve(params['payment_intent_id'])
		render json: {payment: payment }
	end

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

end

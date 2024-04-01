class Api::V1::PaymentsController < ApplicationController
	# before_action :getPropertyId
	# before_action :createProduct
	# before_action :createPrice
  before_action :authenticate_user, :only => [:create, :complete, :index, :get_property_booking]
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
		amount = params[:amount].to_i * 100
		customer_id = current_user.customer_id
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

		@booking = current_user.bookings.create(booking_params)
		# @payment_intent_id = params[:payment_intent]
		# @payment = current_user.payments.new(payment_params)
		if @booking.save
			@property = Property.find_by(id: booking_params[:property_id])
			@property.update(status: 1)
			render json: BookingSerializer.new(@booking).serialized_json, status: 201
		else
			 render json: { error: @booking.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def index
		@bookings  = current_user.bookings 
		if @bookings
			render json: BookingSerializer.new(@bookings).serialized_json, status: 200
		else
			render json: { error: @bookings.errors.full_messages }, status: :unprocessable_entity
		end
	end

	def get_property_booking
	
		@booking  = current_user.bookings.find_by(property_id: params[:property_id])
		if @booking
			render json: BookingSerializer.new(@booking).serialized_json ,status: :ok
		else
			render json: {message: "Not Found"}, status: :unprocessable_entity
		end
	end

	private

	def booking_params
		params.require(:booking).permit(:property_id,:status, payment_attributes: {})
	end

end
# pi_3OzZslSH6OcOxuhn1OuZXnIA
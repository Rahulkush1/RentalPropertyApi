class Api::V1::PayoutsController < ApplicationController 

		def index 
			accounts = Stripe::Account.list({limit: 3})
			render json: accounts
		end

		def create
			# account = Stripe::Account.create({
			#   type: 'custom',
			#   country: 'US',
			#   email: 'socokob540@bayxs.com',
			#   business_type:'company',
			#   capabilities: {
			#     card_payments: {requested: true},
			#     transfers: {requested: true},
			#   },
			# 		tos_acceptance: {
			# 		    date: Time.now.to_i,  # Current Unix timestamp representing the date of acceptance
			# 		    ip: '127.0.0.1',      # The IP address from which the acceptance occurred
			# 		    user_agent: 'Stripe-Test' 
			# 	  }
			# })
			# binding.pry
			# external_account = Stripe::Account.create_external_account(
			# 		  'acct_1OOb8oFQ0FSg864d',
      #   {
      #     external_account: {
      #       object: 'bank_account',
      #       country: 'US',
      #       currency: 'usd',
      #       default_for_currency: true,
      #       account_holder_name: 'John Doe', # Replace with the account holder's name
      #       account_holder_type: 'individual', # or 'company' based on the account type
      #       routing_number: '110000000', # Replace with a valid US routing number
      #       account_number: '000123456789',# Replace with a valid US account number
      #     }
      #   }
			# 		)
			 # binding.pry
			# render json: account
		# 			ex  = Stripe::Account.retrieve_external_account(
		#   'acct_1OOZeh2YMhXsaAno',
		#   'ba_1OOZeq2YMhXsaAno018bb0J6',
		# )
			account = 
Stripe::Account.retrieve_external_account('acct_1OOb8oFQ0FSg864d','ba_1OOdwIFQ0FSg864dV6PyXlya')
binding.pry
			payout = Stripe::Payout.create({
					  amount: 100,
					  currency: 'usd',
					  method: 'standard',
					  source_type: 'bank_account',
					  destination: 'ba_1OOdwIFQ0FSg864dV6PyXlya'
					})
			#   payout = Stripe::Transfer.create({
      #   amount: 1100,
      #   currency: 'usd',
      #   destination: 'acct_1OOb8oFQ0FSg864d', # User's Stripe account ID
        
      # })
		      render json: payout, status: :created
	    rescue Stripe::StripeError => e
	      render json: { error: e.message }, status: :unprocessable_entity
	    end
		
end


# https://connect.stripe.com/d/setup/e/_PCzVC4VkAiitGend7fCuDvsALx/YWNjdF8xT09aV25GWWhtV2dOVVJq/db3e4133a17c1c11c

# acct_1OOZWnFYhmWgNURj

# ba_1OOZeq2YMhXsaAno018bb0J6

# https://connect.stripe.com/oauth/authorize?redirect_uri=https://connect.stripe.com/hosted/oauth&client_id=ca_PCzSQYfHaHZxQZuoGFqrdo4RETp0HCLT&state=onbrd_PD0EVg4DIlie3dpABVGMxLKc8I&response_type=code&scope=read_write&stripe_user[country]=US



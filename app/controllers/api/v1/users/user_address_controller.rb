class Api::V1::Users::UserAddressController < ApplicationController
	 before_action :authenticate_user , :only => [:create]
	def create
		@user = current_user
		if  @user && @user.activated == true
			@user = @user.create_address(user_address_params)
			if @user.save
			 render json: @user , status: :ok
			else
			 render json: @user.errors , status: :unprocessable_entity
			end
		else
			render json: {error: "Account not Found"}, status: 404
		end
	end

	private
	def user_address_params
		params.require(:address).permit(:address_line, :street, :state ,:city, :country)
	end
end
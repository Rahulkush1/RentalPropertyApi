class Api::V1::Users::RegisterationsController < ApplicationController
  require 'securerandom'
  # skip_before_action :authenticate_user, :only => [:create,:confirm_account,:email_confirm]
  before_action :authenticate_user, :only => [:update]

  Not_Authorized = "Not Authorized"
  def create
    @user = User.new(user_params)
    if @user.save
      # @user.add_role(params[:user][:roles][:name])
      render json: @user, status: :created
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if validate_user
      if @user.update(user_params)
        render json: @user, status: :ok 
      else
        render json: @user.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: {error: Not_Authorized}
    end
  end

  def validate_user
    @user = User.find(params[:id])
    if current_user.id == @user.id 
      return true
    else 
      return false
    end
  end

  def email_confirm
    token = JsonWebTokenService.decode(params[:token])
    user = User.find_by(email: token["email"])
    if user.update(activated: true, confirmed_at: Time.current.in_time_zone("Mumbai"))
      render json: {message: "Email is confirmation Successfully, Please Login!"}, status: 200
    else
      render json: {error: "Invalid Token"}, status: :unprocessable_entity
    end
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :firts_name, :last_name, role_ids: [])
    end
end

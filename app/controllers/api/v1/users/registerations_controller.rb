class Api::V1::Users::RegisterationsController < ApplicationController
  require 'securerandom'
  # skip_before_action :authenticate_user, :only => [:create,:confirm_account,:email_confirm]
  before_action :authenticate_user, :only => [:update]

  Not_Authorized = "Not Authorized"
  def create
    binding.pry
    if verify_otp_code?
      @user = User.new(user_params)
      if @user.save
        # @user.add_role(params[:user][:roles][:name])
        token = JsonWebTokenService.encode({ id: @user.id })
        render json:  { user: UserSerializer.new(@user).serialized_json,auth_token: token,
        message: 'Registered Successfully'}, status: :created
      else
        render json: @user.errors.full_messages, status: :unprocessable_entity
      end
    else
      render json: { data: {}, message: 'Please enter a valid phone number' },
             status: :unprocessable_entity
    end
    rescue Twilio::REST::RestError
      render json: { message: 'otp code has expired. Resend code' }, status: :unprocessable_entity
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

  def send_otp_code
    response = VerificationService.new(
      user_params[:phone_number],
      user_params[:country_code]
    ).send_otp_code

    render json: {
      phone_number: user_params[:phone_number],
      country_code: user_params['country_code'],
      message: response
    }
  end

  def verify_otp_code?
      # VerificationService.new(
      #   user_params[:phone_number],
      #   user_params[:country_code]
      # ).verify_otp_code?(params['otp_code'])
      true
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :firts_name, :last_name, :phone_number, :country_code, role_ids: [])
    end
end

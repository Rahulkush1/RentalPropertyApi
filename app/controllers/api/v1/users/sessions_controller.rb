class Api::V1::Users::SessionsController < ApplicationController
  # skip_before_action :authenticate_user, only: [:create]
  before_action :authenticate_user, :only => [:show]
  def create
    @user = User.find_by(email: user_params[:email])
    if @user
      if @user.activated == true
        if @user && @user.authenticate(user_params[:password])
            token = JsonWebTokenService.encode({ id: @user.id })
            render json: { data: {auth_token: token, id: @user.id, email: @user.email} }, status: :ok
        else
          render json: { error: "Incorrect Email Or password" }, status: :unauthorized
        end
      else
        render json: {error: "Account Not found or Unconfirmed account"}, status: :not_found
      end 
    else
      render json: {error: "Account Not found!"}, status: :not_found
    end

  end

  def show
    render json: current_user, status: :ok
  end

  def omniauth_login
    @user = User.from_omniauth(request.env['omniauth.auth'])
    binding.pry
    if @user.persisted?
      token = JsonWebTokenService.encode({ id: @user.id })
      render json: { data: {auth_token: token, id: @user.id, email: @user.email} }, status: :ok
    else
       render json: { error: @user.errors.full_messages }, status: :unauthorized
    end
  end


  private
    def user_params
      params.require(:user).permit(:email, :password)
    end
end

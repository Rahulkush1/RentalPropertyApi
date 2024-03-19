module AuthenticateHelper
  def authenticate_user
    begin
         token = JsonWebTokenService.decode(request.headers['HTTP_AUTH_TOKEN'])
        @current_user = User.find_by(id: token["id"])
        render json: { error: 'Not Authorized' }, status: 401 unless @current_user
        if @current_user.activated == false
          render json: { error: 'Account not activated' }, status: 401
        end
    rescue => e
      render json: {error: "Please Login!"}, status: 401
    end
  end
  def user_sign_in?
    !!current_user
  end
  def current_user
    @current_user
  end

  def token
    JsonWebTokenService.decode(request.headers['HTTP_AUTH_TOKEN'])
  end
end
class Api::AuthenticationController < ::ActionController::API

  def authenticate
    service = AuthenticateUserService.call(params[:email], params[:password])
 
    if service.success?
      render json: { auth_token: service.result }
    else
      render json: { error: service.errors }, status: :unauthorized
    end
  end
 end
class Api::UsersController < Api::ApiController
  def index
    render json: {status: :ok}
  end
end
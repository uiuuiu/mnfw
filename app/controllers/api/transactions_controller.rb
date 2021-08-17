class Api::TransactionsController < Api::ApiController
  before_action :set_user

  def index
    transactions = @user.transactions.includes(:account).page(page_param).per(limit_param)
    render_paginate_data transactions, options: { each_serializer: TransactionSerializer }, meta: {}
  end

  def show
    transaction = @user.transactions.find(params[:id])
    render_data transaction, options: { serializer: TransactionSerializer }, meta: {}
  end

  def create
    service = Api::Transactions::CreateService.call(@user, permit_params)

    if service.success?
      render_data service.result, options: { serializer: TransactionSerializer }, meta: {}
    else
      respond(:transaction_error, 422, service.errors )
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end

  def permit_params
    params.require(:transaction).permit(:account_id, :amount, :transaction_type)
  end
end
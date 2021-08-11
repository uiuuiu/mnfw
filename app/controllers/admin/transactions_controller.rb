class Admin::TransactionsController < Admin::AdminController
  before_action :set_transaction, only: [:destroy, :edit, :update]
  before_action :set_account, only: [:create]
  def index
    render_index do
      Admin::IndexService.call(Transaction, current_user.transactions, page, limit).result
    end
  end

  def new
    render_new do
      Admin::NewService.call(
        current_user.transactions.new,
        editable_columns: [:amount, :transaction_type, :account_id],
        columns_data: {
          account_id: Account.all.pluck(:name, :id)
        }
      ).result
    end
  end

  def edit
    render_edit do
      Admin::EditService.call(
        @transaction,
        columns: [:amount, :transaction_type, :account_id],
        editable_columns: [:amount]
      ).result
    end
  end

  def create
    transaction = @account.transactions.create(permit_params)
    flash[:errors] = transaction.errors.full_messages
    redirect_to_back
  end

  def update
    @transaction.update(permit_update_params(@transaction))
    flash[:errors] = @transaction.errors.full_messages
    redirect_to_back
  end

  def destroy
    @transaction.destroy!
    redirect_to_back
  end

  private

  def set_transaction
    @transaction = current_user.transactions.find(params[:id])
  end

  def set_account
    @account = current_user.accounts.find(params.dig(:transaction, :account_id))
  end

  def permit_params
    params.require(:transaction).permit(:amount, :transaction_type)
  end

  def permit_update_params transaction
    transaction_key = transaction.is_a?(DepositTransaction) ? :deposit_transaction : :withdraw_transaction
    params.require(transaction_key).permit(:amount, :transaction_type)
  end
end

class Admin::AccountsController < Admin::AdminController
  before_action :set_account, only: [:destroy, :edit, :update]
  def index
    render_index do
      Admin::IndexService.call(Account, current_user.accounts, page, limit).result
    end
  end

  def new
    render_new do
      Admin::NewService.call(current_user.accounts.new, editable_columns: [:name, :bank]).result
    end
  end

  def edit
    render_edit do
      Admin::EditService.call(@account, editable_columns: [:name, :bank]).result
    end
  end

  def create
    account = current_user.accounts.create(permit_params)
    flash[:errors] = account.errors.full_messages
    redirect_to_back
  end

  def update
    @account.update(permit_params)
    flash[:errors] = @account.errors.full_messages
    redirect_to_back
  end

  def destroy
    @account.destroy!
    redirect_to_back
  end

  private

  def set_account
    @account = current_user.accounts.find(params[:id])
  end

  def permit_params
    params.require(:account).permit(:name, :bank)
  end
end

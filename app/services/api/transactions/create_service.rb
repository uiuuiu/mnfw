class Api::Transactions::CreateService
  prepend SimpleCommand

  VALID_TRANSACTION_TYPES = {
    'deposit' => 'DepositTransaction',
    'withdraw' => 'WithdrawTransaction'
  }

  def initialize(user, data)
    @user = user
    @data = data
  end

  def call
    if valid?
      data[:transaction_type] = VALID_TRANSACTION_TYPES[data[:transaction_type]]
      transaction = user.transactions.new(data)
      transaction.save!
      transaction
    end
  end

  private

  attr_accessor :user, :data

  def valid?
    is_account_valid? &&
    is_transaction_type_valid?
  end

  def is_account_valid?
    return true if user.accounts.exists?(data[:account_id])
    errors.add(:account_id, 'Account is not valid')
    false
  end

  def is_transaction_type_valid?
    return true if VALID_TRANSACTION_TYPES[data[:transaction_type]].present?
    errors.add(:transaction_type, 'Transaction type is invalid')
    false
  end
end
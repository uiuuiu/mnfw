class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :account_id, :amount, :bank, :transaction_type, :created_at

  attribute :bank do
    object.account.bank
  end

  attribute :transaction_type do
    object.is_a?(DepositTransaction) ? 'deposit' : 'withdraw'
  end
end

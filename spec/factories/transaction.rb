FactoryBot.define do
  factory :deposit_transaction do
    amount { 100.0 }
    transaction_type  { "DepositTransaction" }

    association :account
  end

  factory :withdraw_transaction do
    amount { 100.0 }
    transaction_type  { "WithdrawTransaction" }

    association :account
  end
end
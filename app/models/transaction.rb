class Transaction < ApplicationRecord
    self.inheritance_column = :transaction_type

    enum transaction_type: {
        "DepositTransaction": 'DepositTransaction',
        "WithdrawTransaction": 'WithdrawTransaction'
    }
    
    belongs_to :account

    validates :amount, presence: true, numericality: { greater_than: 0 }
    
end

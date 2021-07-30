class Transaction < ApplicationRecord
    self.inheritance_column = :transaction_type
    
    belongs_to :account

    validates :amount, presence: true
end

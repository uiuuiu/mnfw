class Account < ApplicationRecord

    belongs_to :user
    has_many :transactions
    has_many :deposit_transactions
    has_many :withdraw_transactions

    validates :name, :bank, presence: true
end

class Transaction < ApplicationRecord
    self.inheritance_column = :transaction_type
end

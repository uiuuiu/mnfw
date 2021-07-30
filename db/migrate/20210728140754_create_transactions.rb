class CreateTransactions < ActiveRecord::Migration[6.1]
  def change
    create_table :transactions do |t|
      t.decimal :amount, require: true
      t.string :transaction_type
      t.references :account
      t.timestamps
    end
  end
end

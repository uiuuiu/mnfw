class CreateAccounts < ActiveRecord::Migration[6.1]
  def change
    create_table :accounts do |t|
      t.string :name, require: true
      t.string :bank, require: true
      t.references :user
      t.timestamps
    end
  end
end

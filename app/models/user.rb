class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: [:user, :admin]

  has_many :accounts
  has_many :transactions, through: :accounts
  has_many :deposit_transactions, through: :accounts
  has_many :withdraw_transactions, through: :accounts
end

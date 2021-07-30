require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before do
    user = User.create!(email: 'dy.dev.test1@yopmail.com', password: '12345678')
    Account.create!(name: 'Pham Duy Dy', bank: 'Dy Bank', user_id: user.id)
  end

  subject { Transaction.new(amount: 1000, account_id: Account.last.id) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end

  it "is not valid without an amount" do
    subject.amount = nil
    expect(subject).to_not be_valid
  end

  it "is not valid without an account_id" do
    subject.account_id = nil
    expect(subject).to_not be_valid
  end

  describe 'Deposit' do
    subject { DepositTransaction.new(amount: 1000, account_id: Account.last.id) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "has transaction_type is DepositTransaction" do
      expect(subject.transaction_type).to eq 'DepositTransaction'
    end
  end

  describe 'Withdraw' do
    subject { WithdrawTransaction.new(amount: 1000, account_id: Account.last.id) }

    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "has transaction_type is DepositTransaction" do
      expect(subject.transaction_type).to eq 'WithdrawTransaction'
    end
  end

  describe 'Associations' do
    it { should belong_to(:account) }
  end
end

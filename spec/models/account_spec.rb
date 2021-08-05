require 'rails_helper'

RSpec.describe Account, type: :model do
  before do
    User.create(email: 'dy.dev.test1@yopmail.com', password: '12345678')
  end

  subject { Account.new(name: 'Pham Duy Dy', bank: 'Dy Bank', user_id: User.last.id) }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a name" do
    subject.name = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a bank" do
    subject.bank = nil
    expect(subject).to_not be_valid
  end

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:transactions).without_validating_presence }
    it { should have_many(:deposit_transactions).without_validating_presence }
    it { should have_many(:withdraw_transactions).without_validating_presence }
  end
end

require 'rails_helper'

RSpec.describe User, type: :model do

  subject {
    User.new(email: 'dy.dev.test1@yopmail.com', password: '12345678')
  }

  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  it "is not valid without a email" do
    subject.password = nil
    expect(subject).to_not be_valid
  end
  it "is not valid without a password" do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  describe "Associations" do
    it { should have_many(:accounts).without_validating_presence }
    it { should have_many(:transactions).through(:accounts).without_validating_presence }
    it { should have_many(:deposit_transactions).through(:accounts).without_validating_presence }
    it { should have_many(:withdraw_transactions).through(:accounts).without_validating_presence }
  end
end

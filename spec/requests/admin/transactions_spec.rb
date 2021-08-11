require 'rails_helper'

RSpec.describe "Admin::TransactionsController", type: :request do
  describe "GET /index" do
    before do
      create(:deposit_transaction)
      sign_in User.last
    end
    
    let(:transaction) { Transaction.last }

    it 'display transactions information' do
      get "/management/transactions"

      expect(response).to render_template(:index)
      expect(response.body).to include(transaction.id.to_s)
      expect(response.body).to include(transaction.amount.to_s)
      expect(response.body).to include('DepositTransaction')
    end
  end

  describe "GET /edit" do
    before do
      create(:deposit_transaction)
      sign_in User.last
    end
    
    let(:transaction) { Transaction.last }

    it 'display transactions information' do
      get "/management/transactions/#{transaction.id}/edit"

      expect(response).to render_template(:edit)
      expect(response.body).to include(transaction.amount.to_s)
      expect(response.body).to include('DepositTransaction')
    end
  end
end

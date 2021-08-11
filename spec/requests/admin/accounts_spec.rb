require 'rails_helper'

RSpec.describe "Admin::AccountsController", type: :request do
  describe "GET /index" do
    before do
      create(:account)
      sign_in User.last
    end
    
    let(:account) { Account.last }

    it 'display accounts information' do
      get "/management/accounts"

      expect(response).to render_template(:index)
      expect(response.body).to include(account.id.to_s)
      expect(response.body).to include(account.name)
      expect(response.body).to include(account.bank)
      expect(response.body).to include(account.user_id.to_s)
      expect(response.body).to include(account.created_at.to_s)
      expect(response.body).to include(account.updated_at.to_s)
    end
  end

  describe "GET /edit" do
    before do
      create(:account)
      sign_in User.last
    end
    
    let(:account) { Account.last }

    it 'display accounts information' do
      get "/management/accounts/#{account.id}/edit"

      expect(response).to render_template(:edit)
      expect(response.body).to include(account.name)
      expect(response.body).to include(account.bank)
      expect(response.body).to include(account.user_id.to_s)
    end
  end
end

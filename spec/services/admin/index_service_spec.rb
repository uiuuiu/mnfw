require 'rails_helper'

RSpec.describe Admin::IndexService, type: :model do
  before do
    create(:account)
  end

  let(:current_user) { User.last }
  let(:page) { 1 }
  let(:limit) { 20 }

  describe '#call' do
    it 'success with valid arguments' do
      records, options = Admin::IndexService.call(Account, current_user.accounts, page, limit).result

      expect(records.length).to eq 1

      expected_options = {
        columns: ['id', 'name', 'bank', 'user_id', 'created_at', 'updated_at']
      }
      expect(options[:columns]).to eq expected_options[:columns]
    end

    it 'raise error if first argument is not a model class' do
      message = ''
      begin
        Admin::IndexService.call(1, current_user.accounts, page, limit)
      rescue => exception
        message = exception.message
      end

      expected_message = '1 is not a model class'
      expect(message).to eq expected_message

      class TestModel
      end
      
      begin
        Admin::IndexService.call(TestModel, current_user.accounts, page, limit)
      rescue => exception
        message = exception.message
      end
      expected_message = 'TestModel is not a model'
      expect(message).to eq expected_message
    end
  end
end

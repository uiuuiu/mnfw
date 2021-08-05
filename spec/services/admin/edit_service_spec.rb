require 'rails_helper'

RSpec.describe Admin::EditService, type: :model do
  before do
    create(:account)
  end

  let(:account) { Account.last }

  describe '#call' do
    describe 'success' do
      it 'with one argument: record' do
        record, options = Admin::EditService.call(account).result

        expect(record).to eq account

        expected_options = {
          edit_columns: {
            bank: false,
            name: false,
            user_id: false
          }
        }
        expect(options[:edit_columns]).to eq expected_options[:edit_columns]
      end
      
      it 'with all arguments and opts has editable_columns' do
        record, options = Admin::EditService.call(account, editable_columns: [:name]).result

        expect(record).to eq account

        expected_options = {
          edit_columns: {
            bank: false,
            name: true,
            user_id: false
          }
        }
        expect(options[:edit_columns]).to eq expected_options[:edit_columns]
      end

      it 'with all arguments and opts has columns, editable_columns' do
        record, options = Admin::EditService.call(account, columns: ["bank"], editable_columns: [:name]).result

        expect(record).to eq account

        expected_options = {
          edit_columns: {
            bank: false
          }
        }
        expect(options[:edit_columns]).to eq expected_options[:edit_columns]
      end

      it 'with all arguments and opts has timestamps' do
        record, options = Admin::EditService.call(account, timestamps: true).result

        expect(record).to eq account

        expected_options = {
          edit_columns: {
            name: false,
            bank: false,
            user_id: false,
            created_at: false,
            updated_at: false
          }
        }
        expect(options[:edit_columns]).to eq expected_options[:edit_columns]
      end

      it 'not return id in opts[:edit_columns]' do
        record, options = Admin::EditService.call(account, columns: [:id, :name, :bank]).result
        expected_options = {
          edit_columns: {
            name: false,
            bank: false
          }
        }

        expect(options[:edit_columns]).to eq expected_options[:edit_columns]
      end
    end

    describe 'fail' do
      it 'raise error if first argument is not a model class' do
        message = ''
        begin
          Admin::EditService.call(1)
        rescue => exception
          message = exception.message
        end
  
        expected_message = 'Numeric is not a model'
        expect(message).to eq expected_message
  
        class TestModel
        end
        
        begin
          Admin::EditService.call(TestModel.new)
        rescue => exception
          message = exception.message
        end
        expected_message = 'Object is not a model'
        expect(message).to eq expected_message

        message = ''
        begin
          Admin::EditService.call(nil)
        rescue => exception
          message = exception.message
        end
  
        expected_message = 'Object is not a model'
        expect(message).to eq expected_message
      end
    end
  end
end

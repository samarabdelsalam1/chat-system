require 'swagger_helper'

RSpec.describe 'API V1 Messages', type: :request do
  path '/api/v1/applications/{token}/chats/{number}/messages' do
    post 'Create new message' do
      let!(:chat) { create :chat }
      let!(:number) { chat.number }
      let!(:token) { chat.token }
      parameter name: :token, in: :path, type: :string
      parameter name: :number, in: :path, type: :integer
      consumes 'application/json'
      parameter name: :message, in: :body, schema: {
        type: :object,
        properties: {
          body: { type: :string, example: 'This is a sample message' }
        }
      }
      response '202', 'message created' do
        let(:message) { { body: 'This is a sample message' } }
        run_test!
      end
      response '404', 'Application or chat not found' do
        let(:number) { 1234 }
        run_test!
      end 
    end
  end
  
  path '/api/v1/applications/{token}/chats/{number}/messages/search' do
    get 'Search messages for a specific chat' do
      parameter name: :token, in: :path, type: :string, description: 'Application token'
      parameter name: :number, in: :path, type: :integer, description: 'Chat number'
      parameter name: :query, in: :query, type: :string, description: 'Search query for messages'
      let!(:message) { create :message, body: 'sample search'}
      let!(:number) { message.chat.number }
      let!(:token) { message.chat.token}
      let!(:query) { 'sam' }
      response '200', 'messages found' do
        before do
          Message.reindex          
        end
        run_test! do |response|
          result = JSON.parse(response.body)
          expect(result.length).to eq 1
          expect(result[0]['number']).to eq message.number
        end
      end
      response '404', 'application or chat not found' do
        let(:token) { 'invalid-token' }
        let(:number) { 9999 }
        let(:query) { 'sample search' }
        run_test!
      end
      response '422', 'validation error' do
        let(:query) { '' }
        run_test!
      end
    end
  end
end       

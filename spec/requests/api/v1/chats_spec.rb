require 'swagger_helper'

RSpec.describe 'API V1 Chats', type: :request do
   path '/api/v1/applications/{token}/chats' do
		get 'List all chats for specific application' do		
				let!(:chat) { create :chat }
				let!(:token) { chat.token}
			
			parameter name: :token, in: :path, type: :string, description: 'Application token'

      response '200', 'list chats' do
        run_test! do |response|
					json = JSON.parse(response.body)
          expect(json).not_to be_empty
					expect(json.length).to eq 1
				end
      end
		end
		post 'Create new chat' do
			let!(:application) { create :application } 
			let!(:token) { application.token }
			parameter name: :token, in: :path, type: :string
			response '201', 'List chats for specific application' do
        run_test!
      end
			response '404', 'application found' do
        let(:token) { 'invalid-token' }
        run_test!
      end
		end
	end     
end
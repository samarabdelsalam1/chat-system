require 'swagger_helper'

RSpec.describe 'API V1 Applications', type: :request do
  path '/api/v1/applications' do
    get 'Show all applications' do
      tags 'Application'
      produces 'application/json'
      response '200', 'successful' do
        run_test!
      end
    end

    post 'Create new application' do
      tags 'Application'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :application, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Test Application' }
        },
        required: ['name']
      }

      response '201', 'successful' do
        let(:application) { { name: 'Test Application' } }
        run_test!
      end

      response '422', 'validation error' do
        let(:application) { { name: '' } }
        run_test!
      end
    end
  end

  path '/api/v1/applications/{token}' do
    patch 'Update application' do
      parameter name: :token, in: :path, type: :string
      consumes 'application/json'
      parameter name: :application, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string, example: 'Updated Application Name' }
        },
        required: ['name']
      }

      response '200', 'application updated' do
        let(:token) do
          app = create :application
          app.token
        end
        let(:application) { { name: 'Updated Application Name' } }
        run_test!
      end

      response '422', 'validation error' do
        let(:token) do
          app = create :application
          app.token
        end
        let(:application) { { name: '' } }
        run_test!
      end
    end
  end
end

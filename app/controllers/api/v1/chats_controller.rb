class Api::V1::ChatsController < Api::V1::ApplicationController
    before_action :set_application
    
    def index
      chats = @application.chats
      render json: chats.as_json(except: :id), status: :ok
    end
  
    def create
      application = Application.find_by(token: params[:application_token]) 
      return render json: { error: 'Application not found' }, status: :not_found unless application
      
      next_chat_number = REDIS.incr("application:#{application.id}:next_chat_number")
      ChatCreationJob.perform_async(next_chat_number, application.id)

      render json: { number: next_chat_number }, status: :created
    end
  
    private
  
    def set_application
      
      @application = Application.find_by(token: params[:application_token])
      render json: { error: "Application not found" }, status: :not_found unless @application
    end
end
  
class ChatsController < ApplicationController
    before_action :set_application
    
      def index
      chats = @application.chats
      render json: chats.as_json(except: :id), status: :ok
    end
  
    def create
      chat_number = @application.chats_count + 1
      chat = @application.chats.new(number: chat_number)
  
      if chat.save
        @application.increment!(:chats_count)
        render json: chat.as_json(except: :id), status: :created
      else
        render json: { errors: chat.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    def set_application
      @application = Application.find_by(token: params[:application_token])
      render json: { error: "Application not found" }, status: :not_found unless @application
    end
end
  
class MessagesController < ApplicationController
    before_action :set_chat
  
    # GET /applications/:application_token/chats/:chat_number/messages
    def index
      messages = @chat.messages
      render json: JsonSerializer.serialize(messages), status: :ok
    end
  
    # POST /applications/:application_token/chats/:chat_number/messages
    def create
      message_number = @chat.messages_count + 1
      message = @chat.messages.new(number: message_number, body: message_params[:body])
  
      # instead of the saving the messages directely, send it to a backgroud job to write it to the databse
      # idea: we might temporaya save it to redis database for an hour.
      # also we need to save it to elasticsearch for the search endpoint. 
      if message.save
        @chat.increment!(:messages_count)
        render json: JsonSerializer.serialize(message), status: :created
      else
        render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
      end
    end
  
    private
  
    # Set the chat based on application token and chat number
    def set_chat
      @application = Application.find_by(token: params[:application_token])
      unless @application
        render json: { error: "Application not found" }, status: :not_found
        return
      end
  
      @chat = @application.chats.find_by(number: params[:chat_number])
      render json: { error: "Chat not found" }, status: :not_found unless @chat
    end
  
    # Strong parameters for message creation
    def message_params
      params.require(:message).permit(:body)
    end
  end
  
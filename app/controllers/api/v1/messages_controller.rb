class Api::V1::MessagesController < Api::V1::ApplicationController
  before_action :set_application_and_chat

  # GET /applications/:application_token/chats/:chat_number/messages
  def index
    messages = @chat.messages
    render json: messages.as_json, status: :ok
  end

  # POST /applications/:application_token/chats/:chat_number/messages
  def create
    if message_params[:body].blank?
      render json: { error: 'Message body cannot be blank' }, status: :unprocessable_entity
      return
    end

    next_message_number = REDIS.incr("chat:#{@chat.id}:next_message_number")
    MessageCreationJob.perform_async(@chat.id, next_message_number, message_params[:body])

    render json: { message_number: next_message_number, chat_number: @chat.number, body: message_params[:body] }, status: :accepted
  end

  def search
    if params[:query].blank?
      render json: { error: 'Query parameter is required' }, status: :unprocessable_entity
      return
    end
    results = Message.search(
                      params[:query],
                      fields: [:body],
                      where: {chat_number: @chat.number, token: @application.token},
                      match: :text_middle,
                    )
    filtered_results = results.map do |message|
      message.as_json.except('id', 'chat_id')
    end  
    render json: filtered_results, status: :ok
  end
  
  

  private

  # Set the chat based on application token and chat number
  def set_application_and_chat
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

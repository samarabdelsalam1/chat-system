class MessageCreationJob
  include Sidekiq::Job

  queue_as :message_creation

  def perform(chat_id, message_number, message_body)
    chat = Chat.find(chat_id)
    chat.messages.create!(number: message_number, body: message_body)
  rescue ActiveRecord::RecordInvalid => e
    # Log any validation errors
    Rails.logger.error("Failed to create message: #{e.message}")
  end
end

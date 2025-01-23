class ChatCreationJob
  include Sidekiq::Job

  def perform(chat_number, application_id)
    application = Application.find(application_id)
    application.chats.create!(number: chat_number)
  rescue ActiveRecord::RecordInvalid => e
    Rails.logger.error("Failed to create chat: #{e.message}")
  rescue ActiveRecord::RecordNotFound => e
    Rails.logger.error("Application not found: #{e.message}")
  end
end

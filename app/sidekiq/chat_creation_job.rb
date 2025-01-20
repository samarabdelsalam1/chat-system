class ChatCreationJob
  include Sidekiq::Job

  def perform(chat_number, application_id)
    application = Application.fin(application_id)
    application.chats.create!(number: chat_number)
    rescue ActiveRecord::RecordInvalid => e
      Rails.logger.error("Failed to create chat: #{e.message}")
    end
  end
end

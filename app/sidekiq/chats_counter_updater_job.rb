class ChatsCounterUpdaterJob
  include Sidekiq::Job

  queue_as :chat

  def perform
    Application.find_each do |application|
      chats_count = REDIS.get("application:#{application.id}:chats_count").to_i
      application.update(chats_count: count)
    end
  end
end

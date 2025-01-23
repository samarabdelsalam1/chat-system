class ChatsMessagesCountersUpdaterJob
  include Sidekiq::Job

  def perform
    Application.find_each do |application|
      chats_count = REDIS.get("application:#{application.id}:chats_count").to_i
      application.update(chats_count: count)
      application.chats.find_each do |chat|
        messages_count = REDIS.get("chat:#{chat.id}:messages_count").to_i
        chat.update(messages_count: messages_count)
      end
    end
  end
end

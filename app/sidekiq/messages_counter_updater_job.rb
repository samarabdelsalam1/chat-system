class MessagesCounterUpdaterJob
  include Sidekiq::Job
  queue_as :message

  def perform
    Chat.find_each do |chat|
      messages_count = REDIS.get("chat:#{chat.id}:messages_count").to_i
      chat.update(messages_count: messages_count)
    end
  end
end

class Message < ApplicationRecord
    belongs_to :chat, counter_cache: true

    # include Elasticsearch::Model
    # include Elasticsearch::Model::Callbacks


    validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :number, uniqueness: { scope: :chat_id}
    validates :body, presence: true

    # before_validation :assign_message_number, on: :create

    # settings do
    #     mappings dynamic: 'false' do
    #       indexes :body, type: 'text'
    #     end
    #   end

    #   def self.search_by_body(query)
    #     __elasticsearch__.search(
    #       {
    #         query: {
    #           match: {
    #             body: query
    #           }
    #         }
    #       }
    #     )
    #   end

    # private
    # def assign_message_number
    #     if chat
    #         number ||= chats.messages.maximum(:number).to_i + 1
    #     end
    # end
end

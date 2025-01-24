class Message < ApplicationRecord
    belongs_to :chat, counter_cache: true
    searchkick text_middle: [:body]

    validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :number, uniqueness: { scope: :chat_id}
    validates :body, presence: true
    
    def search_data
      {
        number: number,
        body: body,
        chat_number: chat.number,
        token: chat.application.token,
        created_at: created_at,
        updated_at: updated_at
      }
    end
end

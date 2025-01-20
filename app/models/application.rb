class Application < ApplicationRecord
    has_secure_token :token
    has_many :chats, dependent: :destroy
    
    validates :name, :token, presence: true
    validates :token, uniqueness: true
end

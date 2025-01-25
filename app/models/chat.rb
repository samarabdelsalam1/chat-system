class Chat < ApplicationRecord
    belongs_to :application, counter_cache: true
    has_many :messages, dependent: :destroy
  
    validates :number, presence: true, numericality: { only_integer: true, greater_than: 0 }
    validates :number, uniqueness: { scope: :application_id }
    
    delegate :token, to: :application
  end
  
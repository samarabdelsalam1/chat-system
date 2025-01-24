require 'rails_helper'

RSpec.describe Message, type: :model do
  let!(:application) { create(:application, name: "Valid Application") }
  let!(:chat) { create(:chat, application: application, number: 1) }
  let!(:message) { create(:message, chat: chat, number: 1, body: "Test message") }

  it { should belong_to(:chat) }
  it { should validate_presence_of(:number) }
  it { should validate_numericality_of(:number).only_integer.is_greater_than(0) }
  it { should validate_presence_of(:body) }
  it { should validate_uniqueness_of(:number).scoped_to(:chat_id) }

  it 'validates uniqueness of number scoped to chat_id' do
    new_message = build(:message, chat: chat, number: message.number)
    expect(new_message).not_to be_valid
    expect(new_message.errors[:number]).to include("has already been taken")
  end

  it 'should have a valid factory' do
    message = build(:message, chat: chat)
    expect(message).to be_valid
  end

  it 'should reindex after creating a message' do
    message = build(:message)
    expect(message).to receive(:reindex)
    message.save
  end

  it 'should have correct search data' do
    message = build(:message)
    search_data = message.search_data
    expect(search_data[:number]).to eq(message.number)
    expect(search_data[:body]).to eq(message.body)
    expect(search_data[:chat_number]).to eq(message.chat.number)
    expect(search_data[:token]).to eq(message.chat.application.token)
  end
end

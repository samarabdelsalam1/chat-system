require 'rails_helper'

RSpec.describe Chat, type: :model do
  let!(:application) { create(:application, name: "Valid Application") }
  let!(:chat) { create(:chat, application: application) }

  it { should belong_to(:application) }
  it { should have_many(:messages).dependent(:destroy) }
  it { should validate_presence_of(:number) }
  it { should validate_numericality_of(:number).only_integer.is_greater_than(0) }
  it { should validate_uniqueness_of(:number).scoped_to(:application_id) }

  it 'validates uniqueness of number scoped to application_id' do
    new_chat = build(:chat, application: application, number: chat.number)
    expect(new_chat).not_to be_valid
    expect(new_chat.errors[:number]).to include("has already been taken")
  end

  it 'should have a valid factory' do
    chat = build(:chat, application: application)
    expect(chat).to be_valid
  end
end

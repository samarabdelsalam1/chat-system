require 'rails_helper'

RSpec.describe Application, type: :model do
  let!(:application) { create(:application) }

  it { should have_many(:chats).dependent(:destroy) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:token) }
  it { should validate_uniqueness_of(:token).case_insensitive }

  it 'validates uniqueness of token' do
    new_application = build(:application, name: "New App", token: application.token)
    expect(new_application).not_to be_valid
    expect(new_application.errors[:token]).to include("has already been taken")
  end

  it 'should have a valid factory' do
    application = build(:application)
    expect(application).to be_valid
  end
end

FactoryBot.define do
    factory :chat do
      number { FFaker::Number.unique.number(digits: 3) }
      application
    end
  end
  
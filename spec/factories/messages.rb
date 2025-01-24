FactoryBot.define do
    factory :message do
      number { FFaker::Number.unique.number(digits: 2) }  
      body { FFaker::Lorem.sentence }
      chat
    end
  end
  
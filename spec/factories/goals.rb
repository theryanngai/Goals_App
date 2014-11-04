require 'faker'

FactoryGirl.define do
  factory :goal do
    user_id 3
    completed false
    title Faker::Lorem.word
    body  Faker::Lorem.sentences.join(" ")
    private? [true, false].sample

    factory :completed_goal do
      completed true
    end
  end
end
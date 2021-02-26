FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "user#{n}@example.com" }
    password { 'password' }

    trait :admin do
      role { :admin }
    end
  end
end

FactoryBot.define do
  factory :user do
    name {'テストユーザー'}
    #email {'test1@example.com'}
    sequence(:email) { |n| "test#{n}@mail.com" }
    password {'password'}
    user_category {1}
  end
end

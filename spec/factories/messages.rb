FactoryBot.define do
  factory :message do
    content { '他ユーザーへのメッセージ１' }
    association :user
  end
end
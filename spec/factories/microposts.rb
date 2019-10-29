FactoryBot.define do
  factory :micropost do
    content { 'テスト投稿' }
    micropost_category {2}
    association :user
  end
end
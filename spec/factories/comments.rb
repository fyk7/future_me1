FactoryBot.define do
  factory :comment do
    content { '投稿へのコメント１' }
    association :micropost
  end
end
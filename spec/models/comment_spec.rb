require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:comment) { FactoryBot.build(:comment) }
  let(:blank) { "を入力してください" }
  example 'contentが無ければ無効であること' do
    comment.content = nil
    comment.valid?
    expect(comment.errors[:content]).to include(blank)
  end
  example 'コメントが100文字を超えた場合無効であること' do
    comment.content = 'a' * 101
    comment.valid?
    expect(comment.errors[:content]).to include('は100文字以内で入力してください')
  end
end

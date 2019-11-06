require 'rails_helper'

RSpec.describe Message, type: :model do
  let(:message) { FactoryBot.build(:message) }
  let(:blank) { "を入力してください" }
  example 'contentが無ければ無効であること' do
    message.content = nil
    message.valid?
    expect(message.errors[:content]).to include(blank)
  end
  example 'メッセージが100文字を超えた場合無効であること' do
    message.content = 'a' * 101
    message.valid?
    expect(message.errors[:content]).to include('は100文字以内で入力してください')
  end
end

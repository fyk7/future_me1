require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:micropost) { FactoryBot.build(:micropost) }
  let(:blank) { "を入力してください" }
  example 'contentが無ければ無効であること' do
    micropost.content = nil
    micropost.valid?
    expect(micropost.errors[:content]).to include(blank)
  end
  example 'bodyが200文字を超えた場合無効であること' do
    micropost.content = 'a' * 201
    micropost.valid?
    expect(micropost.errors[:content]).to include('は200文字以内で入力してください')
  end
end

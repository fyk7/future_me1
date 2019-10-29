require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:micropost) { FactoryBot.build(:micropost) }
  let(:blank) { "can't be blank" }
  example 'contentが無ければ無効であること' do
    micropost.content = nil
    micropost.valid?
    expect(micropost.errors[:content]).to include(blank)
  end
  example 'bodyが200文字を超えた場合無効であること' do
    micropost.content = 'a' * 201
    micropost.valid?
    expect(micropost.errors[:content]).to include('is too long (maximum is 200 characters)')
  end
end

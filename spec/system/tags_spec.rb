require 'rails_helper'

#日本語URIのバグを直す必要あり。全角半角問題を修正する必要あり。
describe 'ハッシュタグ機能', type: :system do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:micropost_a) { FactoryBot.create(:micropost, content: '#hashtag　投稿A', user_id: user_a.id) }
  before do
    visit login_path
    fill_in 'email', with: login_user.email
    fill_in 'password', with: login_user.password
    click_button 'ログイン'
  end
  
  context '一覧表示機能' do
    before do
      visit root_path
    end

    context 'ユーザーaがログインしている時' do
      let(:login_user){user_a}

      it 'ユーザーaがハッシュタグを持つ投稿を行い,成功する' do
        FactoryBot.create(:micropost, content: '#hashtag　投稿A')
        expect(page).to have_content '#hashtag　投稿A'
      end

      it 'ハッシュタグをクリックすると、タグのついた投稿一覧に移動する' do
        page.first('#hashtag').click
        expect(page).to have_content '#hashtag　投稿A'
      end
    end

    context 'タグをクリックしたら複数の投稿が表示される' do
      let(:login_user){user_a}
      it 'ハッシュタグをクリックすると、投稿Aと投稿B両方とも変更される' do
        FactoryBot.create(:micropost, content: '#hashtag　投稿B')
        page.first('#hashtag').click
        expect(page).to have_content '#hashtag　投稿A'
        expect(page).to have_content '#hashtag　投稿B'
      end
    end

  end
  
end
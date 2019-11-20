require 'rails_helper'

describe '投稿へのメッセージ機能', type: :system do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:user_b) { FactoryBot.create(:user) }
  let!(:user_c) { FactoryBot.create(:user) }
  let!(:micropost_a) { FactoryBot.create(:micropost, content: 'ユーザーaの投稿', user_id: user_a.id) }
  let!(:comment_a){ FactoryBot.create(:comment, content: 'ユーザーaのコメント', user_id: user_a.id, micropost_id: micropost_a.id)}
  let!(:comment_b){ FactoryBot.create(:comment, content: 'ユーザーbのコメント', user_id: user_b.id, micropost_id: micropost_a.id)}

  before do
    visit login_path
    fill_in 'email', with: login_user.email
    fill_in 'password', with: login_user.password
    click_button 'ログイン'
  end
  
  context '投稿へのメッセージ一覧表示機能' do
    before do
      visit root_path
    end

    context 'ユーザーaがログインしている時' do
      let(:login_user){user_a}

      it 'ユーザーaが作成した投稿が表示される' do
        expect(page).to have_content 'aの投稿'
      end

      it 'ユーザーaの投稿詳細画面にアクセスするとコメントが表示される' do
        click_link '詳細'
        expect(page).to have_content 'aの投稿'
        expect(page).to have_content 'aのコメント'
        expect(page).to have_content 'bのコメント'
      end
    end

  end
  
  context 'コメントの新規作成機能' do
  
    before do
      visit root_path
      click_link '詳細'
    end

    context '新規作成画面で名称を入力した時' do
    let(:login_user){user_c}
      it '正常に投稿される' do
        
      end
    end
  end

  context 'コメント削除機能' do

    context 'ログインしているユーザー自身なら投稿を削除できる' do
      let(:login_user){user_b}
      before do
        visit root_path
        click_link '詳細'
      end

      it 'ユーザーb自身のコメントが削除できる' do
       
      end
    end

  end
end
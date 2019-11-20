require 'rails_helper'

describe '投稿機能', type: :system do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:user_b) { FactoryBot.create(:user) }
  let!(:micropost_a) { FactoryBot.create(:micropost, content: 'ユーザーaの最初の投稿', user_id: user_a.id) }
  let!(:micropost_b) { FactoryBot.create(:micropost, content: 'ユーザーbの最初の投稿', user_id: user_b.id) }
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

      it 'ユーザーaが作成した投稿が表示される' do
        expect(page).to have_content 'aの最初の投稿'
      end
    end

    context 'ユーザーbがログインしている時' do
      let(:login_user){user_b}

      it 'ユーザーbが作成した投稿が表示される' do
        expect(page).to have_content 'bの最初の投稿'
      end
    end
  end
  
  context '投稿新規作成機能' do
    let(:login_user){user_a}

    before do
      visit root_path
      fill_in 'content', with: content_name
      click_button '投稿'
    end

    context '投稿新規作成画面で名称を入力した時' do
      let(:content_name){'新規作成した投稿'}

      it '正常に投稿される' do
        expect(page).to have_selector '.alert-primary', text: '投稿しました！'
      end
    end

    context '投稿新規作成画面で名称を入力しなかった時' do
      let(:content_name){''}

      it 'エラーとなる！' do
        expect(page).to have_selector '.alert-danger', text: '投稿内容を記入してください!'
      end
    end
  end

  context '投稿削除機能' do

    context 'ログインしているユーザー自身なら投稿を削除できる' do
      let(:login_user){user_a}
      before do
        visit root_path
      end

      it 'ユーザーa自身の投稿が削除できる' do
        page.first('#delete').click
        expect(page).to have_selector '.alert-primary', text: '投稿を削除しました！'
      end
    end

    context 'ログインしていないユーザーは削除できない' do
      let(:login_user){user_a}
      before do
        visit root_path
      end

      #it 'ユーザーbはユーザーaの投稿を削除できない' do
        #expect(page).to_not have_selector '#delete'
      #end
    end

  end
end
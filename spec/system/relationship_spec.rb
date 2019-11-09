require 'rails_helper'

describe 'フォロー機能', type: :system do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:user_b) { FactoryBot.create(:user) }
  before do
    visit login_path
    fill_in 'email', with: login_user.email
    fill_in 'password', with: login_user.password
    click_button 'ログイン'
  end

  context 'フォロー、フォロー解除機能が正常である' do
    before do
      visit users_path
    end

    context 'ユーザーaがログインしている時' do
      let(:login_user){user_a}

      it 'ユーザー一覧にフォロワー数0が表示される' do
        expect(page).to have_content '0 フォロワー'
      end
      
      context 'ユーザーbの詳細ページで' do
        before do
          visit user_path(user_b)
        end

        it 'ユーザーaがユーザーbをフォローできる' do
          expect(page).to have_content user_b.name
          expect(page).to have_content '0 フォロワー'
          click_button 'フォローする'
          sleep 1
          expect(page).to have_content '1 フォロワー'
        end

        it 'ユーザーaがユーザーbへのフォローを解除できる' do
          expect(page).to have_content user_b.name
          click_button 'フォローする'
          sleep 1
          expect(page).to have_content '1 フォロワー'
          click_button 'フォローを解除'
          sleep 1
          expect(page).to have_content '0 フォロワー'
        end

      end

      context 'ユーザーaの詳細ページで' do
        before do
          visit user_path(user_a)
        end
        
        it 'フォローボタンが表示されない' do
          expect(page).to have_content user_a.name
          expect(page).to_not have_button 'Follow'
        end
      end
      
    end
  end
end
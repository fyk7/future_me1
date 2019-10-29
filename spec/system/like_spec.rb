require 'rails_helper'
describe 'いいね機能', type: :system, js: true do
  let!(:user_a) { FactoryBot.create(:user) }
  let!(:user_b) { FactoryBot.create(:user) }
  let!(:micropost_a) { FactoryBot.create(:micropost, user_id: user_a.id) }
  let!(:micropost_b) { FactoryBot.create(:micropost, user_id: user_b.id) }
  before do
    visit login_path
    fill_in 'email', with: user_a.email
    fill_in 'password', with: user_a.password
    click_button 'ログイン'
  end
  context ' ツイートが自分のものではないとき ' do
    before do
      visit root_path
    end
    context 'いいねボタンを押していないとき' do
      it 'いいねボタンを押せること' do
        expect(page).to have_css '.like-btn'
        first('.like-btn').click
        expect(page).to have_css '.like-btn-unlike'
      end
    end
    context 'いいねボタンを押しているとき' do
      before do
        first('.like-btn').click
      end
      it 'いいねの解除ができること' do
        expect(page).to have_css '.like-btn-unlike'
        first('.like-btn-unlike').click
        expect(page).to have_css '.like-btn'
      end
    end
  end
  #context 'ツイートが自分のもののとき' do
    #before do
      #visit "/tweets/#{tweet_a.id}"
   # end
   # it 'いいねボタンが表示されないこと' do
   #   expect(page).not_to have_css '.likebtn'
    #end
  #end
end
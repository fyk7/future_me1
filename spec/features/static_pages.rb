require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  describe 'Home' do
    specify 'タイトル内容の表示' do
      visit root_path
      expect(page).to have_title 'Ruby on Rails Tutorial Sample App'
    end
  end
  
  describe 'Help' do
    specify 'タイトル内容の表示' do
      visit help_path
      expect(page).to have_title 'Help | Ruby on Rails Tutorial Sample App'
    end
  end
  
  describe 'About' do
    specify 'タイトル内容の表示' do
      visit about_path
      expect(page).to have_title 'About | Ruby on Rails Tutorial Sample App'
    end
  end
end
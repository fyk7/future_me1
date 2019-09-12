require 'rails_helper'

RSpec.feature "StaticPages", type: :feature do
  describe 'User new page' do
    specify 'タイトル内容の表示' do
      visit signup_path
      expect(page).to have_http_status(200) #have_content('Users_new') 
    end
  end
end
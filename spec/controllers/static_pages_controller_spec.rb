require 'rails_helper'

RSpec.describe StaticPagesController, type: :controller do

  describe "静的ページの表示機能" do
    it "トップページが正しく表示される" do
      get :home
      expect(response).to have_http_status(:success)
    end
  end
end
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_tags
  before_action :set_liked_microposts
 
  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "ログインしてください"
      redirect_to login_url
    end
  end

  def set_tags
    if logged_in?
      @tags = Tag.all.order(created_at: :desc).limit(10)
    end
  end

  def set_liked_microposts
    if logged_in?
      recent_micropost = Micropost.where(created_at:1.months.ago..Time.now)
      @recent_microposts = recent_micropost.order(likes_count: :desc).limit(3)
    end
  end


end

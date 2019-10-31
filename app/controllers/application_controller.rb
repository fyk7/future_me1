class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  before_action :set_tags
  before_action :set_microposts
  
  def search
    #Viewのformで取得したパラメータをモデルに渡す(出来ればransack化)
    @posts = Micropost.search(params[:search])
  end

  private

  def logged_in_user
    unless logged_in?
      store_location
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def set_tags
    if logged_in?
      @tag_all_pages = Tag.all.order(created_at: :desc).limit(15)
    end
  end

  def set_microposts
    if logged_in?
      recent_micropost = Micropost#.order(created_at: :desc).limit(100)
      @recent_microposts = recent_micropost.order(likes_count: :desc).limit(5)
    end
  end


end

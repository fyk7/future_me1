class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost_form  = current_user.microposts.build
      @all_user_microposts = Micropost.all.order(created_at: :desc).page(params[:page]).per(25)
    end
  end

  def help
  end

  def help
  end

  def about
  end
end

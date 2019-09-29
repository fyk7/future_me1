class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost_form  = current_user.microposts.build
      @microposts = Micropost.all.order(created_at: :desc).page(params[:page]).per(25)
      @user = current_user

      #@q = User.ransack(params[:q])
      #@users = @q.result(distinct: true)
      
    end
  end

  def help
  end

  def about
  end
end

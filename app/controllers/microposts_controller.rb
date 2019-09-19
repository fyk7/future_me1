class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿しました！"
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:success] = "投稿を削除しました！"
    redirect_to request.referrer || root_url
  end

  def show 
    @micropost = Micropost.find_by(id: params[:id])
    @user = @micropost.user
    @likes_count = Like.where(micropost_id: @micropost.id).count
  end

  def edit
    @micropost = Micropost.find_by(id: params[:id])
    @user = @micropost.user
    @micropost_form  = current_user.microposts.build
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end

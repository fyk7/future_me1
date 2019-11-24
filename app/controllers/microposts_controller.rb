class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = "投稿しました！"
      redirect_to root_url
    else
      @micropost_form  = current_user.microposts.build
      @microposts = Micropost.all.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
      @user = current_user
      flash[:danger] = "投稿内容を記入してください!"
      redirect_to root_url
    end
  end

  def destroy
    @micropost.destroy
    flash[:notice] = "投稿を削除しました！"
    redirect_to root_url
  end

  def show 
    @micropost = Micropost.find_by(id: params[:id])
    @comment = Comment.new
    @comments = @micropost.comments 
  end

  def rank_all
    @microposts = Micropost.find(Like.group(:micropost_id).order('count(micropost_id) desc').limit(10).pluck(:micropost_id))
  end

  def search
    @q = Micropost.ransack(content_or_user_name_cont_any: params[:q].split(' '))
    @microposts = @q.result.page(params[:page]).per(10)
  end

  def index
    @q = Micropost.ransack(params[:q])
    @microposts = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def hashtags
    tag = Tag.find_by(name: params[:name])
    @microposts = tag.microposts.page(params[:page]).per(10)
    @tag = tag
  end

  def tag_index
    @tag = Tag.all.order(created_at: :desc)
  end

  private

    def micropost_params
      params.require(:micropost).permit(:content, :picture, :micropost_category)
    end

    def correct_user
      @micropost = current_user.microposts.find_by(id: params[:id])
      redirect_to root_url if @micropost.nil?
    end
end

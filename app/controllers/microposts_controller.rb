class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:notice] = "投稿しました！"
      redirect_to root_url
    else
      @all_user_microposts = []
      render 'static_pages/home'
    end
  end

  def destroy
    @micropost.destroy
    flash[:notice] = "投稿を削除しました！"
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

  def rank_all
    @microposts = Micropost.find(Like.group(:micropost_id).order('count(micropost_id) desc').limit(10).pluck(:micropost_id))
    #@microposts = Micropost.order('likes_count desc').limit(10).pluck(:micropost_id))
  end

  #def student
    #@microposts = Micropost.where(micropost_category: [1,2,3]).order(created_at: :desc).page(params[:page]).per(15)
  #end

  #def recruit
    #@microposts = Micropost.where(micropost_category: 4).order(created_at: :desc).page(params[:page]).per(15)
  #end

  #def work_rookie
    #@microposts = Micropost.where(micropost_category: 5).order(created_at: :desc).page(params[:page]).per(15)
  #end
  
  #Viewのformで取得したパラメータをモデルに渡す
  def search
    @microposts = Micropost.search(params[:search_micropost]).page(params[:page]).per(15)
  end

  def index
    @q = Micropost.ransack(params[:q])
    @microposts = @q.result(distinct: true).page(params[:page]).per(15)
  end

  def hashtags
    tag = Tag.find_by(name: params[:name])
    @microposts = tag.microposts.page(params[:page]).per(15)
    @tag = tag
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

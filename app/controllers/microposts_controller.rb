class MicropostsController < ApplicationController
  before_action :logged_in_user, only: [:create, :destroy]
  before_action :correct_user,   only: :destroy

  def create
    @micropost = current_user.microposts.build(micropost_params)
    if @micropost.save
      flash[:success] = "投稿しました！"
      redirect_to root_url
    else
      @all_user_microposts = []
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

  def rank_all
    @microposts = Micropost.find(Like.group(:micropost_id).order('count(micropost_id) desc').limit(20).pluck(:micropost_id))
  end
  
 # def rank_all
  #  micropost_like_count = Micropost.joins(:likes).group(:micropost_id).count
   # micropost_liked_ids = Hash[micropost_like_count.sort_by{ |_, v| -v }].keys
    #@microposts= Micropost.where(id: micropost_liked_ids)
  #end

  def recruit
    @microposts = Micropost.where(micropost_category: 4)#.find(Like.group(:micropost_id).order('count(micropost_id) desc').limit(20).pluck(:micropost_id))
  end

  def work_rookie
    @microposts = Micropost.where(micropost_category: 5)
  end

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    @microposts = Micropost.search(params[:search]).page(params[:page]).per(25)
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

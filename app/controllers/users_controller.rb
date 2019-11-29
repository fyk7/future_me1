class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy,  :following, :followers]
  before_action :correct_user,   only: [:edit, :update]

  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.all.order(created_at: :desc).page(params[:page]).per(20)
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      unless @isRoom
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.image_name = "default_user.jpeg"#デフォルトプロフィール
    if @user.save
      log_in(@user)
      flash[:notice] = "Future⇀meへようこそ！"
      redirect_to root_url
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:notice] = "プロフィールをアップデートしました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def following
    @title = "フォローしているユーザー一覧"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(10)
    render 'show_follow'
  end

  def followers
    @title = "フォロワー一覧"
    @user  = User.find(params[:id])
    @users = @user.followers.page(params[:page]).per(10)
    render 'show_follow'
  end

  private

    def user_params
      params.require(:user).permit(:name, :email, :password,
        :password_confirmation, :image_name, :user_category, :image)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end

end

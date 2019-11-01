class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :index, :destroy,  :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  before_action :admin_user,     only: :destroy

  def index
    @users = User.all.order(created_at: :desc).page(params[:page]).per(10)
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.all.order(created_at: :desc).page(params[:page]).per(20)
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
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
    @user.image_name = "default_user.png"#デフォルトプロフィール
    if @user.save
      log_in(@user)
      flash[:notice] = "Future⇀meへようこそ！"
      redirect_to user_url(@user)
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    #if params[:image]
      #@user.image_name = "#{@user.id}.jpg"
      #image = params[:image_name]
      #File.binwrite("public/user_images/#{@user.image_name}",image.read)
    #end
    if @user.update_attributes(user_params)
      flash[:notice] = "プロフィールをアップデートしました"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:notice] = "User deleted"
    redirect_to users_url
  end

  def likes
  end

  def search
    #Viewのformで取得したパラメータをモデルに渡す
    #@users = User.search(params[:search_user]).page(params[:page]).per(25)
  end

  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.page(params[:page]).per(10)
    render 'show_follow'
  end

  def followers
    @title = "Followers"
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

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end

end

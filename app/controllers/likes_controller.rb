class LikesController < ApplicationController

  def create
    @user = User.find(params[:id])
    @like = Like.new(user_id: @user.id, micropost_id: params[:micropost_id])
    @like.save
    redirect_to root
  end

  def destroy
    @user = User.find(params[:id])
    @like = Like.find_by(user_id: @user.id, micropost_id: params[:micropost_id])
    @like.destroy
    redirect_to root
  end
  
end

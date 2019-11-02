class LikesController < ApplicationController
  before_action :set_post

  def create
    @like = Like.create(user_id: current_user.id, micropost_id: params[:micropost_id])
    @likes = Like.where(micropost_id: params[:micropost_id])
    @micropost.reload
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, micropost_id: params[:micropost_id])
    like.destroy
    @likes = Like.where(micropost_id: params[:micropost_id])
    @micropost.reload
  end

  private

  def set_post
    @micropost = Micropost.find(params[:micropost_id])
  end
  
end
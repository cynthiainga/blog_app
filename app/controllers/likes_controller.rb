class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    post = Post.find(params[:post_id])
    Like.creat(author: current_user, post:)
    redirect_to use_post_path(current_user, post)
end

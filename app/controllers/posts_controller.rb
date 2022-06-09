class PostsController < ApplicationController
  def index
    @user = current_user
  end

  def new
    @post = Post.new
    @user = current_user
  end

  def create
    Post.create(post_params)
    redirect_to { user_posts(current_user) }
  end

  def show
    @post = Post.includes(:comments).find(params[:id])
  end

  private

  def post_params
    a_post = params.require(:post).permit(:title, :text)
    a_post[:author] = current_user
    a_post
  end

  def post_params_setu
    Post.create(author: current_user, title: params[:post][:title], text: params[:post][:text])
  end
end

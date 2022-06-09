class CommentsController < ApplicationController
  def new
    @comment = Comment.new
    @user = current_user
  end

  def create
    post = Post.find(params[:post_id])
    Comment.create(post_params(post))
    redirect_to user_post_path(current_user, post)
  end

  private

  def post_params(post)
    a_post = params.require(:comment).permit(:text)
    a_post[:author] = current_user
    a_post[:post] = post
    a_post
  end
end

class PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(20)
  end

  def show
    @post = Post.find(params[:id])
    @replies = @post.replies.page(params[:page]).per(20)
    @reply = Reply.new
    # @post.views_count += 1
  end
end

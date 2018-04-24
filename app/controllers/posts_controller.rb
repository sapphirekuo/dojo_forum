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

  def new
    @post = Post.new
    @categories = Category.all
  end

  def create
    @post = Post.new(post_params)
    @post.user = current_user
    if @post.save
      flash[:notice] = "post was successfully created"
      redirect_to posts_path
    else
      flash.now[:alert] = "post was failed to create"
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image, :categoty_id)
  end
end

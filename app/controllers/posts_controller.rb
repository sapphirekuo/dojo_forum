class PostsController < ApplicationController
  def index
    @posts = Post.where(status: "Published").page(params[:page]).per(20)
    @categories = Category.all
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

  def feeds
    @users = User.all
    @posts = Post.where(status: "Published").all
    @replies = Reply.all
    @chatterbox = User.order(replies_count: :desc).limit(10)
    @top10_posts = Post.order(replies_count: :desc).limit(10)
    
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image, :categoty_id)
  end
end

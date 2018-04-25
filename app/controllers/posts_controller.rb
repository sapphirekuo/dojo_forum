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
      
      if published?
        flash[:notice] = "post was successfully created"
        @post.status = "Published"
        @post.save
        redirect_to posts_path
      elsif draft?
        flash[:notice] = "post was save as draft"
        @post.status = "Draft"
        @post.save
        redirect_to my_draft_user_path(current_user)
      end
      
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

  def collect
    @post = Post.find(params[:id])
    @post.collects.create!(user: current_user)
    # redirect_back(fallback_location: root_path)  # 導回上一頁
  end

  def uncollect
    @post = Post.find(params[:id])
    collects = Collect.where(post: @post, user: current_user)
    collects.destroy_all
    #redirect_back(fallback_location: root_path)
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image, :categoty_id, :status)
  end

  def published?
    params[:commit] == "Publish"   
  end

  def draft?
    params[:commit] == "Save as Draft"
  end

end


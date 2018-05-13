class PostsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  def index
    if current_user
      posts = Post.readable_by(current_user).where(status: "Published")
    else
      posts = Post.where(authorized: "all", status: "Published")
    end
    # posts = Post.readable_by(current_user).where(status: "Published")
    @q = posts.ransack(params[:q])

    @posts = @q.result.order(id: :asc).page(params[:page]).per(20)

    # @posts = Post.readable_by(current_user).order(created_at: :desc).page(params[:page]).per(20)
    @categories = Category.all
  end

  def show
    if @post.readable_by(current_user) && @post.status == "Published"
      @replies = @post.replies.page(params[:page]).per(20)
      if params[:reply_id]
        @reply = Reply.find(params[:reply_id])
      else
        @reply = Reply.new
      end
    else
      redirect_to posts_path
      flash[:alert] = "you are not authorized to see that post"
    end
    # @post.views_count += 1
    @post.count_view
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

  def edit
    if @post.user == current_user
      @categories = Category.all
    else
      redirect_to posts_path
      flash[:alert] = "you are not allowed to edit other's post"
    end
  end

  def update
    @post.user = current_user
    if @post.save      
      if published?
        flash[:notice] = "post was successfully updated"
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
      flash.now[:alert] = "post was failed to update"
      render :edit
    end   
  end

  def destroy
    @post.destroy
    redirect_to root_path
    flash[:alert] = "post was deleted"
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

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :description, :image, :categoty_id, :status, :authorized)
  end

  def published?
    params[:commit] == "Create Post" || params[:commit] == "Update Post"   
  end

  def draft?
    params[:commit] == "Save as Draft"
  end

end


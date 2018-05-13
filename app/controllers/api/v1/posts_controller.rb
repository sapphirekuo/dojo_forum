class Api::V1::PostsController < ApiController
  before_action :authenticate_user!, except: :index

  def index
    if current_user
      @posts = Post.readable_by(current_user).where(status: "Published")
    else
      @posts = Post.where(authorized: "all", status: "Published")
    end
  end

  def show
  @post = Post.readable_by(current_user).find_by(id: params[:id])
    if !@post
      render json: {
        message: "Can't find the post!",
        status: 400
      }
    else
      render "api/v1/posts/show"
    end
  end

  def create
    @post = Post.new(post_params)
    if @post.save
      render json: {
        message: "Post created successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def update
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      render json: {
        message: "Post updated successfully!",
        result: @post
      }
    else
      render json: {
        errors: @post.errors
      }
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])
    @post.destroy
    render json: {
      message: "Post destroy successfully!"
    }
  end

  private

  def post_params
    params.permit(:title, :description, :user, :authorized)
  end
end

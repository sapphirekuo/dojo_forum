class Api::V1::PostsController < ApiController
  def index
    @posts = Post.all
    render json: {
      data: @posts.map do |post|
        {
          title: post.title,
          description: post.description
         }
      end
    }
  end

  def show
  @post = Post.find_by(id: params[:id])
    if !@post
      render json: {
        message: "Can't find the post!",
        status: 400
      }
    else
      render json: {
        title: @post.title,
        description: @post.description
      }
    end
end

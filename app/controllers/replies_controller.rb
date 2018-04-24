class RepliesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to post_path(@post)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end
end

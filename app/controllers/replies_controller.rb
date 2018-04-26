class RepliesController < ApplicationController
  before_action :set_reply, only: [:update, :destroy]

  def create
    @post = Post.find(params[:post_id])
    @reply = @post.replies.build(reply_params)
    @reply.user = current_user
    @reply.save!
    redirect_to post_path(@post)
  end

  def update
    @post = Post.find(params[:post_id])
    if @reply.update(reply_params)
      redirect_back(fallback_location: root_path)
      flash[:notice] = "reply was successfully updated"
    else
      
      redirect_back(fallback_location: root_path)
    end
  end 

  def destroy
    @post = Post.find(params[:post_id])
    @reply.destroy
    flash[:alert] = "reply was successfully deleted"
    redirect_back(fallback_location: root_path)
  end

  private

  def reply_params
    params.require(:reply).permit(:comment)
  end

  def set_reply
    @reply = Reply.find(params[:id])
  end
end

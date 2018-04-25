class UsersController < ApplicationController
  before_action :set_user
 
  def show
    @posts = @user.posts.where(status: "Published")
  end

  def edit
    unless @user == current_user
      redirect_to user_path(@user)
    end
  end

  def update
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def my_comment
    
  end

  def my_collect

  end

  def my_draft
    @posts = @user.posts.where(status: "Draft")
     
  end

  def my_friend
    
  end

  private

  def set_user
     @user = User.find(params[:id])
   end

  def user_params
    params.require(:user).permit(:name, :introduction, :avatar)
  end
end

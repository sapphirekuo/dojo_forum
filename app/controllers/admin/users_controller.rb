class Admin::UsersController < Admin::BaseController
  def index
    @users=User.page(params[:page]).per(10)  
  end

  def update
    set_user
    if @user.update(user_params)
      redirect_to admin_users_path
      flash[:notice] = "user was successfully updated"
    else
      @users = User.page(params[:page]).per(10)  
      render :index
    end    
  end

  private

  def user_params
    params.require(:user).permit(:role)
  end

  def set_user
    @user = User.find(params[:id])
  end
end

class CategoriesController < ApplicationController
  def show
    @categories = Category.all
    @category = Category.find(params[:id])
    # @posts = @category.posts.readable_by(current_user).page(params[:page]).per(20)
    posts = @category.posts.readable_by(current_user).where(status: "Published")
    @q = posts.ransack(params[:q])

    @posts = @q.result.order(id: :asc).page(params[:page]).per(20)

  end
end

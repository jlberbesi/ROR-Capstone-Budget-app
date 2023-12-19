class CategoriesController < ApplicationController
  def index
    @categories = Category.where(user_id: current_user.id)
    @current_user = current_user
  end

  def new
    @category = Category.new
    @owner = current_user
  end

  def create
    @category_info = Category.new(new_category_params)
    @category_info.user_id = current_user.id

    if @category_info.save
      flash[:notice] = 'The category was created successfully!'
    else
      flash[:alert] = 'The category could not be created!'
    end
    redirect_to categories_path
  end

  private

  def new_category_params
    params.require(:category).permit(:name, :icon)
  end
end

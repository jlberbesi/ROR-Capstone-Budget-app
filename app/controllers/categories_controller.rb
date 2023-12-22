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
      redirect_to categories_path
    else
      flash[:alert] = 'The category could not be created!'
      render :new
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category = Category.find(params[:id])
    if @category.update(new_category_params)
      redirect_to categories_path, notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @category = Category.find(params[:id])

    CategoryAcquisition.where(category_id: @category.id).delete_all

    @category.destroy

    redirect_to categories_path, notice: 'Category was successfully deleted.'
  end

  private

  def new_category_params
    params.require(:category).permit(:name, :icon)
  end
end

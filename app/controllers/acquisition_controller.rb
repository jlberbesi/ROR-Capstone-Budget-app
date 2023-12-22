class AcquisitionController < ApplicationController
  def show
    if Category.exists?(params[:id])
      @category = Category.find(params[:id])
      @acquisitions = CategoryAcquisition.where(category_id: params[:id]).includes(:acquisition).order(created_at: :desc)

      sum_amount = 0
      @acquisitions.each do |item|
        sum_amount += item.acquisition.amount
      end
      @category.update(sumamount: sum_amount)
    else
      redirect_to categories_path, alert: 'Category not found.'
    end
  end

  def new
    @category = Category.find(params[:category_id])
    @acquisition = Acquisition.new
  end

  def create
    @acquisition = Acquisition.new(acquisition_params)
    @acquisition.author_id = current_user.id

    if @acquisition.save
      CategoryAcquisition.create(category_id: params[:category_id], acquisition_id: @acquisition.id)
      redirect_to acquisition_path(params[:category_id]), notice: 'Transaction was successfully created.'
    else
      render :new
    end
  end

  def edit
    @acquisition = Acquisition.find(params[:id])
  end

  def update
    @acquisition = Acquisition.find(params[:id])
    if @acquisition.update(acquisition_params)

      redirect_to categories_path, notice: 'Transaction was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @acquisition = Acquisition.find(params[:id])

    CategoryAcquisition.where(acquisition_id: @acquisition.id).delete_all

    @acquisition.destroy

    redirect_to categories_path, notice: 'Transaction was successfully deleted.'
  end

  private

  def acquisition_params
    params.require(:acquisition).permit(:name, :amount)
  end
end

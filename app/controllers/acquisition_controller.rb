class AcquisitionController < ApplicationController
  def show
    @category = Category.find(params[:id])
    @acquisitions = CategoryAcquisition.where(category_id: params[:id]).includes(:acquisition).order(created_at: :desc)

    sum_amount = 0

    @acquisitions.each do |item|
      sum_amount += item.acquisition.amount
    end

    @category.update(sumamount: sum_amount)
  end

  def new
    @category = params[:id]
    @acquisition = Acquisition.new
  end

  def create
    @acquisition = Acquisition.new(acquisition_params)
    @acquisition.author_id = current_user.id
    @acquisition.save

    @category_acquisition = CategoryAcquisition.new
    @category_acquisition.category_id = params[:id]
    @category_acquisition.acquisition_id = @acquisition.id
    @category_acquisition.save
    redirect_to acquisition_path(params[:id])
  end

  private

  def acquisition_params
    params.require(:acquisition).permit(:name, :amount)
  end
end

class CatRentalRequestsController < ApplicationController

  def new
    @cat_rental_request = CatRentalRequest.new
    render :new
  end

  def create
    @cat_rental_request = CatRentalRequest.new(cat_rental_request_params)
    if @cat_rental_request.save
      redirect_to cat_url(@cat_rental_request.cat)
    else

      flash.now[:errors] = @cat_rental_request.errors.full_messages
      render :new
    end
  end

  def approve

    @rental_request ||= CatRentalRequest.includes(:cat).find(params[:id])
    @rental_request.approve!

    redirect_to cats_url
  end

  def deny
    @rental_request ||= CatRentalRequest.includes(:cat).find_by(id: params[:id])
    @rental_request.deny!
    redirect_to cat_url(@rental_request.cat)
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end

end

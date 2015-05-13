class CatRentalRequestsController < ApplicationController
  def new
    @request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @request = CatRentalRequest.new(cat_rental_request_params)
    if @request.save
      flash[:notice] = "You successfully rented this cat!"
      redirect_to cat_path(@request.cat_id)
    else
      flash.now[:errors] = @request.errors.full_messages
      @cats = Cat.all
      render :new
    end
  end

  def approve
    @request = CatRentalRequest.new(cat_rental_request_params)
    @request.approve!
  end

  def deny
    @request = CatRentalRequest.new(cat_rental_request_params)
    @request.deny!
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end

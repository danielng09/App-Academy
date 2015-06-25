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

  def update
    @request = CatRentalRequest.find(params[:id])
    case cat_rental_request_params[:status]
    when "APPROVE"
      @request.approve!
      flash[:notice] = "Request from #{@request.start_date} - #{@request.end_date} has been approved!"
    when "DENY"
      @request.deny!
      flash[:notice] = "Request from #{@request.start_date} - #{@request.end_date} has been denied!"
    end
    redirect_to cat_path(@request.cat_id)
  end

  private

  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end
end

class BandsController < ApplicationController
  before_action :redirect_to_sign_up_unless_signed_in

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.create(band_params)
    if @band.save
      redirect_to @band
    else
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def index
    @bands = Band.all
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    @band.update!(band_params)
    redirect_to @band
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    redirect_to bands_url
  end

  private
  def band_params
    params.require(:band).permit(:name)
  end

end

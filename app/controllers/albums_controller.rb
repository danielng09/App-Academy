class AlbumsController < ApplicationController
  before_action :redirect_to_sign_up_unless_signed_in
  
  def new
    @album = Album.new
    @band = Band.find(params[:band_id])
    @bands = Band.all
    render :new
  end

  def create
    @album = Album.create(album_params)
    @band = Band.find(params[:album][:band_id])
    @bands = Band.all
    if @album.save
      redirect_to @album
    else
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def edit
    @album = Album.find(params[:id])
    @band = @album.band
    @bands = Band.all
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    @album.update!(album_params)
    redirect_to @album
  end

  def destroy
    @album = Album.find(params[:id])
    @band = @album.band
    @album.destroy
    redirect_to @band
  end

  private
  def album_params
    params.require(:album).permit(:name, :band_id, :record_type)
  end
end

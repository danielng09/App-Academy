class TracksController < ApplicationController
  before_action :redirect_to_sign_up_unless_signed_in

  def new
    @track = Track.new
    @album = Album.find(params[:album_id])
    @albums = Album.all
    render :new
  end

  def create
    @track = Track.create(track_params)
    @album = Album.find(params[:track][:album_id])
    @albums = Album.all
    if @track.save
      redirect_to @album
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def index
    @tracks = Track.all
  end

  def show
    @track = Track.find(params[:id])
    @album = @track.album
    render :show
  end

  def edit
    @track = Track.find(params[:id])
    @album = @track.album
    @albums = Album.all
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    @track.update!(track_params)
    redirect_to @track
  end

  def destroy
    @track = Track.find(params[:id])
    @album = @track.album
    @track.destroy
    redirect_to @album
  end

  private
  def track_params
    params.require(:track).permit(:name, :album_id, :track_type, :lyrics)
  end
end

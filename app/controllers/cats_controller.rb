class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @cat = Cat.new
    if @cat.save
      redirect_to cats_path
    else
      flash.now[:errors] = @cat.errors.full_message
      render :new
    end
  end
end

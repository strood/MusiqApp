class BandsController < ApplicationController
  before_action :require_user!
  before_action :require_user_activated!
  before_action :require_user_admin!, only: [:create, :new, :edit, :update, :destroy]

  def index
     @bands = Band.all
     render :index
  end

  def create
    @band = Band.new(band_params)

    if @band.save
      flash[:notice] = ["Created new band: #{ @band.name }"]
      redirect_to band_url(@band)
    else
      flash[:errors] = ["Invalid Band Info, please try again"]
      redirect_to new_band_url
    end

  end

  def new
    @band = Band.new
    render :new
  end

  def edit
    @band = Band.find(params[:id])

    if @band
      render :edit
    else
      flash[:errors] = ["Invalid Band"]
      redirect_to bands_url
    end
  end

  def show
    @band = Band.find(params[:id])

    if @band
      render :show
    else
      flash[:errors] = ["Invalid Band"]
      redirect_to bands_url
    end
  end

  def update
    @band = Band.find(params[:id])

    if @band.update(band_params)
      flash[:notice] = ["Successfully Updated #{ @band.name }"]
      redirect_to band_url(@band)
    else
      flash[:errors] = ["Unable to update band"]
      redirect_to band_url(@band)
    end

  end

  def destroy
      @band = Band.find(params[:id])
      name = @band.name

      if @band.destroy!
        flash[:notice] = ["Band: #{ @band.name } successfully deleted"]
        redirect_to bands_url
      else
        flash.now[:errors] = ["Cannot delete band:#{ @band.name }"]
        redirect_to band_url(@band)
      end
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end

end

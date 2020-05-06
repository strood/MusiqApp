class AlbumsController < ApplicationController
  before_action :require_user!

  def create
    @album = Album.new(album_params)

    if @album.complete?
      if Album.valid_year?(@album.year)
        if @album.save
          flash[:notice] = ["Created new album #{ @album.title }"]
          redirect_to album_url(@album)
        else
          flash[:errors] = ["Invalid Album Info, please try again"]
          redirect_to new_band_album_url(@album.band_id)
        end
      else

        flash[:errors] = ["Invalid album year"]
        redirect_to new_band_album_url(@album.band_id)
      end

    else
      flash[:errors] = ["Incomplete album info"]
      redirect_to new_band_album_url(@album.band_id)
    end

  end

  def new
    @album = Album.new
    render :new
  end

  def edit
    @album =  Album.find(params[:id])

    if @album
      render :edit
    else
      flash[:errors] = ["Invalid Album"]
      redirect_to bands_url
    end
  end

  def show
    @album = Album.find(params[:id])

    if @album
      render :show
    else
      flash[:errors] = ["Invalid Album"]
      redirect_to bands_url
    end
  end

  def update
    @album = Album.find(params[:id])

    if Album.valid_year?(params[:album][:year].to_i)

      if @album.update(album_params)
        flash[:notice] = ["Successfully Updated #{ @album.title }"]
        redirect_to album_url(@album)
      else
        flash[:errors] = ["Unable to update album"]
        redirect_to album_url(@album)
      end

    else

      flash[:errors] = ["Invalid album year"]
      redirect_to edit_album_url(@album)
    end
  end

  def destroy
    @album = Album.find(params[:id])
    band = @album.band
    if @album.destroy!
      flash[:notice] = ["Album destroyed"]
      redirect_to band_url(band)
    else
      flash[:errors] = ["Unable to delete album"]
      redirect_to album_url(@album)
    end
  end

  private

  def album_params
    params.require(:album).permit(:band_id, :title, :year, :live)
  end
end

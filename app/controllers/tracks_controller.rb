class TracksController < ApplicationController
  before_action :require_user!
  before_action :require_user_activated!
  before_action :require_user_admin!, only: [:create, :new, :edit, :update, :destroy]

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(tracks_params)

    if @track.valid?
      if @track.save
        flash[:notice] = ["Created new track #{ @track.name }"]
        redirect_to track_url(@track)
      else
        flash[:errors] = ["Invalid track info, pelase try again"]
        redirect_to new_album_track_url(@track.album_id)
      end
    else
      flash[:errors] = ["Invalid track parameter, please try again"]
      redirect_to new_album_track_url(@track.album_id)
    end
  end

  def edit
    @track = Track.find(params[:id])

    if @track
      render :edit
    else
      flash[:errors] = ["Unable to find track"]
      redirect_to bands_url
    end
  end

  def show
    @track = Track.find(params[:id])
    if @track
      render :show
    else
      flash[:errors] = ["Unable to find track"]
      redirect_to bands_url
    end
  end

  def update
    @track = Track.find(params[:id])

    if @track.update(tracks_params)
      flash[:notice] = ["Successfully updated #{ @track.name }"]
      redirect_to track_url(@track)
    else
      flash[:errors] = ["Unable to update track!"]
      redirect_to track_url(@track)
    end

  end

  def destroy
    @track = Track.find(params[:id])

    if @track.destroy
      flash[:notice] = ["Successfully deleted #{ @track.name }"]
      redirect_to album_url(@track.album)
    else
      flash[:errors] = ["Unable to delete track!"]
      redirect_to album_url(@track.album)
    end
  end

  private

  def tracks_params
    params.require(:track).permit(:name, :album_id, :ord, :bonus, :lyrics)
  end
end

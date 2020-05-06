class NotesController < ApplicationController
  def create
    @note = Note.new(note_params)

    @note.user_id = current_user.id
    @note.track_id = params[:note][:track]

    if @note.save
      flash[:notice] = ["Successfully created note"]
      redirect_to track_url(@note.track)
    else
      flash[:errors] = ["Error creating note"]
      redirect_to track_url(@notes.track)
    end
  end

  def destroy
    @note = Note.find(params[:id])

    if @note

      if @note.destroy
        flash[:notice] = ["Deleted note"]
        redirect_to track_url(@note.track)
      else
        flash[:errors] = ["Cannot destroy note"]
        redirect_to track_url(@note.track)
      end
    else
      flash[:errors] = ["Invalid Note, cannot destroy"]
      redirect_to bands_url
    end
  end

  private

  def note_params
    params.require(:note).permit(:content)
  end
end

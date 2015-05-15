class NotesController < ApplicationController

  def create
    @note = Note.new(note_params)
    @note.user_id = current_user.id
    track = Track.find(note_params[:track_id])
    unless @note.save
      flash[:errors] = @note.errors.full_messages
    end
    redirect_to track_url(track)
  end

  def destroy

  end

  private

  def note_params
    params.require(:note).permit(:body, :track_id, :track_id)
  end

end

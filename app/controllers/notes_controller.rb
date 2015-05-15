class NotesController < ApplicationController
  before_action

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
    @note = Note.find(params[:id])
    if deleter_is_not_owner_of_note?(@note)
      render :file => File.join(Rails.root, 'public', '500.html'), status: :forbidden
    else
      @note.destroy
      redirect_to track_url(@note.track)
    end
  end

  private

  def note_params
    params.require(:note).permit(:body, :track_id, :track_id)
  end

  def deleter_is_not_owner_of_note?(note)
    current_user != note.user
  end

end

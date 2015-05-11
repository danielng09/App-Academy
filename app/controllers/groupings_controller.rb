class GroupingsController < ApplicationController
  def create
    grouping = Grouping.new(grouping_params)
    if grouping.save
      render json: grouping
    else
      render(
        json: grouping.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def destroy
    grouping = Grouping.find(params[:id])
    grouping.destroy
    render json: grouping
  end

  def grouping_params
    params.require(:groupings).permit(:group_id, :contact_id)
  end
end

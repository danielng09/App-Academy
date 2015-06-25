class GroupsController < ApplicationController
  def index
    @groups = User.find(params[:user_id]).groups
  end

  def show
    @group = Group.find(params[:id])
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    render json: :destroyed
  end

  def create
    @group = User.find(params[:user_id]).groups.new(group_params)
    # @group = Group.new(group_params)
    # @group.user_id = params[:user_id]
    if @group.save
      render 'show.json.jbuilder'
    else
      render(
        json: @group.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def group_params
    params.require(:group).permit(:group_name)
  end
end

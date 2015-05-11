class GroupsController < ApplicationController
  def index
    render json: User.find(params[:user_id]).groups
  end

  def show
    render json: Group.find(params[:id])
  end

  def destroy
    group = Group.find(params[:id])
    group.destroy
    render json: group
  end

  def create
    group = Group.new(group_params)
    if group.save
      render json: group
    else
      render(
        json: group.errors.full_messages, status: :unprocessable_entity
      )
    end
  end

  def group_params
    params.require[:group].permit(:user_id, :group_name)
  end
end

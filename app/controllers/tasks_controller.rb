require 'json'

class TasksController < ApplicationController
  respond_to :json

  def list_tasks
    respond_with Task.where(list_id: task_params[:list_id]).order('updated_at DESC'), location: nil
  end

  def destroy
    respond_with Task.find(task_params[:id]).update(status: 'complete'), location: nil
  end

  def create
    respond_with Task.create(task_params), location: nil
  end

  private

  def task_params
    params.require(:task).permit(:id, :list_id, :title, :notes, :user_id)
  end

end
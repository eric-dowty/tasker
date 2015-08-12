require 'json'

class TasksController < ApplicationController
  respond_to :json

  def list_tasks
    respond_with Task.where(list_id: task_params[:list_id]).order('updated_at DESC'), location: nil
  end

  def destroy
    respond_with Task.find(task_params[:id]).update(status: 'complete'), location: nil
  end

  private

  def task_params
    params.require(:task).permit(:id, :list_id)
  end

end
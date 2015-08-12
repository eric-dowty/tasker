require 'json'

class TasksController < ApplicationController
  respond_to :json

  def list_tasks
    respond_with Task.with_user_info(task_params[:list_id]), location: nil
  end

  def destroy
    respond_with Task.find(task_params[:id]).switch_status, location: nil
  end

  def update
    respond_with Task.update(params[:id], task_params), location: nil
  end

  def create
    respond_with Task.create(task_params), location: nil
  end

  def by_list_and_status
    respond_with Task.with_user_info_by_status(task_params[:list_id]), location: nil
  end

  def by_list_and_title
    respond_with Task.with_user_info_by_title(task_params[:list_id]), location: nil
  end

  def by_list_and_due_date
    respond_with Task.with_user_info_by_due_date(task_params[:list_id]), location: nil
  end

  private

  def task_params
    params.require(:task).permit(:id, :list_id, :title, :notes, :user_id, :start_date, :due_date)
  end

end
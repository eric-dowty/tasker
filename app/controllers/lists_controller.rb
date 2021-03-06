require 'json'

class ListsController < ApplicationController
  respond_to :json

  def index
    @user = logged_in_user
  end

  def show
    respond_with List.find(params[:id]), location: nil
  end

  def create
    respond_with List.create(list_params), location: nil
  end

  def update
    respond_with List.update_list(params[:id], list_params), location: nil
  end

  def destroy
    respond_with List.find(params[:id]).destroy, location: nil
  end

  def all_lists
    respond_with List.includes(:tasks).all.order('updated_at DESC'), location: nil
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end

end
require 'json'

class ListsController < ApplicationController
  respond_to :json

  def index
    #Capybara view tests
  end

  def show
    #Capybara view tests
  end

  def edit
    #API endpoint
  end

  def create
    respond_with List.create(list_params), location: nil
  end

  def update
    updated_list = List.update_list(params[:id], list_params)
    respond_with updated_list, location: nil
  end

  def destroy
    #API endpoint
  end

  def all_lists
    #API endpoint
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end

end
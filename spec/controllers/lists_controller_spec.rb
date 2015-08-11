require 'rails_helper'

RSpec.describe ListsController, type: :controller do

  describe 'POST #create' do
    it 'can create a new list' do 
      expect(List.count).to eq(0)
      params = { title: 'new list', description: 'a new list' }
      post :create, format: :json, list: params
      data = List.first
      expect(List.count).to eq(1)
      expect(data[:title]).to eq('new list')
      expect(data[:description]).to eq('a new list')
    end
  end

  describe 'PUT #update' do
    it 'can update a list title and description' do
      List.create(title: 'new list', description: 'a new list')
      list = List.first
      expect(list[:title]).to eq('new list')
      expect(list[:description]).to eq('a new list')
      params = { title: 'changed list', description: 'a changed list' }
      put :update, format: :json, id: list.id, list: params
      updated_list = List.first
      expect(updated_list[:title]).to eq('changed list')
      expect(updated_list[:description]).to eq('a changed list')
    end

    it 'can update a list title' do
      List.create(title: 'new list', description: 'a new list')
      list = List.first
      expect(list[:title]).to eq('new list')
      expect(list[:description]).to eq('a new list')
      params = { title: 'changed list' }
      put :update, format: :json, id: list.id, list: params
      updated_list = List.first
      expect(updated_list[:title]).to eq('changed list')
      expect(updated_list[:description]).to eq('a new list')
    end

    it 'can update a list description' do
      List.create(title: 'new list', description: 'a new list')
      list = List.first
      expect(list[:title]).to eq('new list')
      expect(list[:description]).to eq('a new list')
      params = { description: 'a changed list' }
      put :update, format: :json, id: list.id, list: params
      updated_list = List.first
      expect(updated_list[:title]).to eq('new list')
      expect(updated_list[:description]).to eq('a changed list')
    end

    it 'can will not update a list with a nil title' do
      List.create(title: 'new list', description: 'a new list')
      list = List.first
      expect(list[:title]).to eq('new list')
      expect(list[:description]).to eq('a new list')
      params = { title: nil }
      put :update, format: :json, id: list.id, list: params
      updated_list = List.first
      expect(updated_list[:title]).to eq('new list')
      expect(updated_list[:description]).to eq('a new list')
    end

    it 'can will not update a list with an empty string title' do
      List.create(title: 'new list', description: 'a new list')
      list = List.first
      expect(list[:title]).to eq('new list')
      expect(list[:description]).to eq('a new list')
      params = { title: '' }
      put :update, format: :json, id: list.id, list: params
      updated_list = List.first
      expect(updated_list[:title]).to eq('new list')
      expect(updated_list[:description]).to eq('a new list')
    end
  end

  describe 'DELETE #destroy' do
    it 'can delete a list' do
      expect(List.count).to eq(0)
      List.create(title: 'new list', description: 'a new list')
      expect(List.count).to eq(1)
      list = List.first
      delete :destroy, format: :json, id: list.id
      expect(List.count).to eq(0)
    end
  end

  describe 'GET #all_lists' do
    it 'can return all lists' do
      3.times { List.create(title: 'new list', description: 'a new list') }
      get :all_lists, format: :json
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data.count).to eq(3)
      expect(data[0][:title]).to eq('new list')
    end
  end

  describe 'GET #show' do
    it 'can return a single list' do
      List.create(title: 'first list', description: 'a new list')
      List.create(title: 'second list', description: 'a new list')
      List.create(title: 'third list', description: 'a new list')
      list = List.second
      get :show, format: :json, id: list.id
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:title]).to eq('second list')
    end
  end

end
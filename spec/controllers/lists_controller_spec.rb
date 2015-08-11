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

end
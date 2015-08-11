require 'rails_helper'

RSpec.describe UsersController, type: :controller do

  describe 'GET #show' do
    it 'can get a users data' do
      user = User.create(nickname: 'test user', image_url: 'test url')
      get :show, format: :json, id: user.id
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data[:nickname]).to eq('test user')
      expect(data[:image_url]).to eq('test url')
    end
  end

end
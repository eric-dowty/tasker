require 'rails_helper'

RSpec.describe List, type: :model do

  it 'is valid with proper attributes' do
    list = List.create(title: 'new list', description: 'this is a new list')
    expect(list).to be_valid
    expect(List.first.title).to eq('new list')
    expect(List.first.description).to eq('this is a new list')
  end

  it 'is invalid without a title' do
    list = List.create(title: nil, description: 'this is a new list')
    expect(list).to be_invalid
  end

end
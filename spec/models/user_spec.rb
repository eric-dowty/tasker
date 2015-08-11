require 'rails_helper'

RSpec.describe User, type: :model do

  it 'is valid' do
    user = User.create(nickname: 'Guest', 
                       email: 'eric.m.dowty@gmail.com', 
                       image_url: 'http://www.itshughal.com/wp-content/uploads/2014/07/Guest-Post-Icon-01-150x150.png',
                       token: 'token',
                       provider: 'guest_account',
                       uid: 'uid')
    expect(user).to be_valid
  end

  it 'has many tasks' do
    list = List.create(title: 'new list', description: 'this is a new list')
    user = User.create(nickname: 'Guest', 
                       email: 'eric.m.dowty@gmail.com', 
                       image_url: 'http://www.itshughal.com/wp-content/uploads/2014/07/Guest-Post-Icon-01-150x150.png',
                       token: 'token',
                       provider: 'guest_account',
                       uid: 'uid')
    3.times do
      Task.create(list_id:    list.id,
                  user_id:    user.id,
                  title:      'new task',
                  status:     'incomplete',
                  notes:      'some notes',
                  due_date:   DateTime.now,
                  start_date: DateTime.now)
    end
    expect(user.tasks.count).to eq(3)
  end

end
require 'rails_helper'

RSpec.describe Task, type: :model do

  before(:each) do
    @user = User.create(nickname: 'Guest', 
                       email: 'eric.m.dowty@gmail.com', 
                       image_url: 'http://www.itshughal.com/wp-content/uploads/2014/07/Guest-Post-Icon-01-150x150.png',
                       token: 'token',
                       provider: 'guest_account',
                       uid: 'uid')
    @list = List.create(title: 'new list', description: 'a new list')
  end

  it 'is valid with proper attributes' do
    task = Task.create(list_id:    @list.id,
                       user_id:    @user.id,
                       title:      'new task',
                       status:     'incomplete',
                       notes:      'some notes',
                       due_date:   DateTime.now,
                       start_date: DateTime.now)
    expect(task).to be_valid
  end

  it 'is invalid without a title' do
    task = Task.create(list_id:    @list.id,
                       user_id:    @user.id,
                       title:      nil,
                       status:     'incomplete',
                       notes:      'some notes',
                       due_date:   DateTime.now,
                       start_date: DateTime.now)
    expect(task).to be_invalid
  end

  it 'has a default status of incomplete' do
    task = Task.create(list_id:    @list.id,
                       user_id:    @user.id,
                       title:      nil,
                       notes:      'some notes',
                       due_date:   DateTime.now,
                       start_date: DateTime.now)
    expect(task.status).to eq('incomplete')
  end

  it 'belongs to a user and a list' do
    task = Task.create(list_id:    @list.id,
                       user_id:    @user.id,
                       title:      nil,
                       notes:      'some notes',
                       due_date:   DateTime.now,
                       start_date: DateTime.now)
    expect(task.user).to eq(@user)
    expect(task.list).to eq(@list)
  end

  xit 'is invalid with a start date in the past' do
    task = Task.create(list_id:    @list.id,
                       user_id:    @user.id,
                       title:      'new task',
                       status:     'incomplete',
                       notes:      'some notes',
                       due_date:   DateTime.now,
                       start_date: Date.yesterday)
    expect(task).to be_invalid
  end

  xit 'is invalid with a due date in the past' do
    task = Task.create(list_id:    @list.id,
                       user_id:    @user.id,
                       title:      'new task',
                       status:     'incomplete',
                       notes:      'some notes',
                       due_date:   Date.yesterday,
                       start_date: DateTime.now)
    expect(task).to be_invalid
  end

  xit 'is invalid with a start and due date in the past' do
    task = Task.create(list_id:    @list.id,
                       user_id:    @user.id,
                       title:      'new task',
                       status:     'incomplete',
                       notes:      'some notes',
                       due_date:   Date.yesterday,
                       start_date: DateTime.yesterday)
    expect(task).to be_invalid
  end

end
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

end
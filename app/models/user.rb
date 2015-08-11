class User < ActiveRecord::Base
  has_many :tasks

  def self.guest_user
    guest_user = User.find_by(nickname: "Guest") 
    guest_user ? guest_user : create_guest_user
  end

  def self.create_guest_user
    User.create(nickname: 'Guest', 
                image_url: 'http://www.itshughal.com/wp-content/uploads/2014/07/Guest-Post-Icon-01-150x150.png',
                )
  end

  def self.find_or_create_from_auth(data)
    user = User.find_or_create_by(provider: data.provider, uid: data.uid)

    user.email     = data.info.email
    user.nickname  = data.info.nickname
    user.image_url = data.info.image
    user.token     = data.credentials.token
    user.save

    user
  end

end
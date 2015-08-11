class Seed

  def self.go
    Rails.env == "production" ? production : development
  end

  def self.production
    create_guest_user
    create_lists
    create_tasks
  end 

  def self.development
    create_guest_user
    create_lists
    create_tasks
  end 

  def self.create_guest_user
    User.create(nickname: 'Guest', 
                image_url: 'http://www.itshughal.com/wp-content/uploads/2014/07/Guest-Post-Icon-01-150x150.png',
                )
    puts 'Guest user created'
  end

  def self.create_lists
    user_id = User.find_by(nickname: "Guest").id
    10.times { List.create(title: Faker::Lorem.word, description: Faker::Lorem.sentence) }
    puts '10 lists created'
  end 

  def self.create_tasks
    user_id = User.find_by(nickname: "Guest").id
    List.all.each do |list|
      5.times do 
        list.tasks << Task.create(title:      Faker::Lorem.word, 
                                  status:     random_status,
                                  notes:      Faker::Lorem.sentence,
                                  user_id:    user_id,
                                  due_date:   Faker::Date.forward(random_days_ahead),
                                  start_date: Faker::Date.between(2.days.ago, Date.today))
      end
    end
    puts "50 tasks created"
  end

  def self.random_status
    ['incomplete', 'incomplete', 'complete'].sample
  end 

  def self.random_days_ahead
    [2,3,4,5,6,7,8].sample
  end

end

Seed.go
class List < ActiveRecord::Base
  validates :title, presence: true
  has_many :tasks

  def self.update_list(id, updates)
    list = List.find(id)
    list.update(updates) ? List.find(id) : list
  end

end
class List < ActiveRecord::Base
  validates :title, presence: true
  has_many :tasks

  def self.update_list(id, updates)
    list = List.find(id)
    if list.update(updates)
      get_updated_list(list.id)
    else
      list
    end
  end

  def self.get_updated_list(id)
    List.find(id)
  end

end
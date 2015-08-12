require 'json'

class Task < ActiveRecord::Base
  validates :title, presence: true
  belongs_to :list
  belongs_to :user
  before_create :set_dates_if_none_entered_or_in_the_past

  def set_dates_if_none_entered_or_in_the_past
    self.start_date = Time.now unless start_date && start_date >= Date.today
    self.due_date   = (Time.now + (7*24*60*60)) unless due_date && due_date >= Date.today
  end

  def switch_status
    if status == "complete"
      self.update(status: 'incomplete')
    else
      self.update(status: 'complete')
    end
  end

  def self.with_user_info(list_id)
    tasks = Task.includes(:user).where(list_id: list_id).where(status: 'incomplete').order('updated_at DESC')
    tasks.map do |task|
      { image_url: task.user.image_url, task: task }.to_json
    end
  end

end


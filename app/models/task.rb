class Task < ActiveRecord::Base
  validates :title, presence: true
  belongs_to :list
  belongs_to :user
end
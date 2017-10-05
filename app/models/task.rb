class Task < ActiveRecord::Base
  belongs_to :boss
  belongs_to :worker#, through: :boss
  has_many :worker_tasks
end

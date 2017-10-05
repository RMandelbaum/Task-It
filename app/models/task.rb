class Task < ActiveRecord::Base
  belongs_to :boss
  belongs_to :worker, through: :boss
end

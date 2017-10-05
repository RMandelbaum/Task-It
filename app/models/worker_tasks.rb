class WorkerTask < ActiveRecord::Base
  belongs_to :worker
  belongs_to :task
end

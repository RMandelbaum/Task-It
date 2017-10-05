class Worker < ActiveRecord::Base
  belongs_to :boss
  has_many :tasks #, through: :boss
  has_many :worker_tasks
  has_secure_password
  validates :username, presence: true



  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
      Worker.all.find{|worker| worker.slug == slug}

  end
end

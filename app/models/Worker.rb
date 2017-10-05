class Worker < ActiveRecord::Base
  belongs_to :boss
  has_many :tasks, through: :boss
  has_secure_password
  #validate username, presence: true



  def slug
    name.downcase.gsub("","-")
  end

  def self.find_by_slug(slug)
      Worker.all.find{|worker| worker.slug == slug}

  end
end

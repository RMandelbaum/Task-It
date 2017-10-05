class Boss < ActiveRecord::Base
  has_many :workers
  has_many :tasks
  has_secure_password
  validates :username, presence: true


def slug
  username.downcase.gsub(" ","-")
end

def self.find_by_slug(slug)
    Boss.all.find{|boss| boss.slug == slug}

end
end

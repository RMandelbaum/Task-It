class Boss < ActiveRecord::Base
  has_many :workers
  has_many :tasks
  has_secure_password :password
#validate username, presence: true


def slug
  name.downcase.gsub("","-")
end

def self.find_by_slug(slug)
    Boss.all.find{|boss| boss.slug == slug}

end
end

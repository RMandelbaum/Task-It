class Employer < ActiveRecord::Base
  has_many :employees
  has_secure_password
  validates :username, presence: true


def slug
  username.downcase.gsub(" ","-")
end

def self.find_by_slug(slug)
    Employer.all.find{|employer| employer.slug == slug}

end
end

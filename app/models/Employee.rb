class Employee < ActiveRecord::Base
  belongs_to :employer
  has_many :tasks
  has_secure_password
  validates :username, presence: true
  


  def slug
    username.downcase.gsub(" ","-")
  end

  def self.find_by_slug(slug)
      Employee.all.find{|employee| employee.slug == slug}

  end
end

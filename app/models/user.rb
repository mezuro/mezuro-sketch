class User < ActiveRecord::Base
  has_many :projects
  acts_as_authentic
end

class User < ActiveRecord::Base
  validates_presence_of :login, :password, :email

  validates_format_of :email, :with => /^.+@.+$/

  validates_uniqueness_of :login

end

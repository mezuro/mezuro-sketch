class User < ActiveRecord::Base
  acts_as_authentic
  
  #validates_format_of :email, :with => /^.+@.+$/
  
end

class User < ActiveRecord::Base
  has_many :projects

  validate :if_login_is_login
  acts_as_authentic

  def if_login_is_login
    errors.add("Use \"login\" as login") if self.login =~ /^login$/
  end
end

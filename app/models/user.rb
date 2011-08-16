class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  has_many :check_ins
  validates_presence_of :password, :on => :create
end

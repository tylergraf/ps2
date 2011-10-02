class User < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation
  has_secure_password
  has_many :tasks
  validates_presence_of :password_digest, :on => :create
  before_create { generate_token(:auth_token) }

  validates :email, :presence => true,
                    :format => {:with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i},
                    :uniqueness => true
  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
end

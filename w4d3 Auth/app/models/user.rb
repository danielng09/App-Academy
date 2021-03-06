# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  username        :string(255)      not null
#  password_digest :string(255)      not null
#  created_at      :datetime
#  updated_at      :datetime
#

class User < ActiveRecord::Base
  validates :username, :password_digest, presence: true
  validates :username, uniqueness: true
  after_save :set_session_token
  attr_reader :password
  has_many :cats
  has_many :cat_rental_requests
  has_many :sessions

  def self.find_by_credentials(arguments)
    user = User.find_by(username: arguments[:username])
    (user && user.is_password?(arguments[:password])) ? user : nil
  end

  def set_session_token
    new_token = SecureRandom.urlsafe_base64
    Session.create!(user_id: self.id, session_token: new_token)
  end

  def reset_session_token!
    self.session_token = SecureRandom.urlsafe_base64
    self.save!
    session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

end

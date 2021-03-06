# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  password_digest :string           not null
#  session_token   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base
  validates :email, :password_digest, :session_token, presence: true
  validate :ensure_session_token
  after_initialize :ensure_session_token
  has_many :subs, foreign_key: :moderator_id
  has_many :comments, foreign_key: :author_id
  attr_reader :password


  def self.find_by_credentials(email, password)
    user = User.find_by_email(email)
    if user && user.is_password?(password)
      user
    else
      nil
    end
  end

  def self.generate_token
      SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = User.generate_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= User.generate_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(password_digest).is_password?(password)
  end



end

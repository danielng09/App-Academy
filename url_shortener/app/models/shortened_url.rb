class ShortenedUrl < ActiveRecord::Base
  validates :submitter_id, :presence => true
  validates :short_url, :presence => true, :uniqueness => true
  validates :long_url, :presence => true

  def self.random_code
    code = SecureRandom::urlsafe_base64(12)
    while ShortenedUrl.exists?(:short_url => code)
      code = SecureRandom::urlsafe_base64(12)
    end
    code
  end

  def self.create_for_user_and_long_url!(user, long_url)
    code = self.random_code
    self.create!(:submitter_id => user.id, :long_url => long_url, :short_url => code)
  end

  belongs_to(
    :submitter,
    :class_name => 'User',
    :foreign_key => :submitter_id,
    :primary_key => :id
  )

end

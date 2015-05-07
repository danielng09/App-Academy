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

  has_many(
    :visits,
    :class_name => 'Visit',
    :foreign_key => :shortened_url_id,
    :primary_key => :id
  )

  has_many(
    :visitors,
    Proc.new { distinct },
    :through => :visits,
    :source => :visitor
  )

  def num_clicks
    self.visits.count
  end

  def num_uniques
    self.visitors.count
  end

  def num_recent_uniques
    self.visits.where(["created_at BETWEEN ? AND ?", 10.minutes.ago, Time.now]).count
  end
end

class ShortenedUrl < ActiveRecord::Base
  validates :submitter_id, :presence => true
  validates :short_url, :presence => true, :uniqueness => true
  validates :long_url, :presence => true

  def self.random_code
    loop do
      code = SecureRandom::urlsafe_base64(12)
      return code unless ShortenedUrl.exists?(:short_url => code)
    end
  end

  def self.create_for_user_and_long_url!(user, long_url)
    code = ShortenedUrl.random_code
    ShortenedUrl.create!(:submitter_id => user.id, :long_url => long_url, :short_url => code)
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
    visits.count
  end

  def num_uniques
    visitors.count
  end

  def num_recent_uniques
    visits.where(["created_at < ?", 10.minutes.ago]).count
  end
end

# == Schema Information
#
# Table name: tracks
#
#  id         :integer          not null, primary key
#  album_id   :integer          not null
#  name       :string           not null
#  track_type :string           not null
#  lyrics     :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Track < ActiveRecord::Base
  validates :album_id, :name, :track_type, :lyrics, presence: true
  validates :track_type, inclusion: { in: %w(regular bonus),
            message: "%{value} is not a valid option" }
  belongs_to :album
  has_one :band, through: :album, source: :band
  has_many :notes
end

# == Schema Information
#
# Table name: albums
#
#  id          :integer          not null, primary key
#  name        :string           not null
#  band_id     :integer          not null
#  record_type :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Album < ActiveRecord::Base
  validates :name, :band_id, :record_type, presence: true
  validates :record_type, inclusion: { in: %w(live studio),
            message: "%{value} is not a valid option" }
  has_many :tracks, dependent: :destroy
  belongs_to :band

end

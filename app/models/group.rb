# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  group_name :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
  belongs_to :user
  has_many :groupings
  has_many :grouped_contacts, through: :groupings
  validates :group_name, presence: true, uniqueness: { scope: :user_id }
end

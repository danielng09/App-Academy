# == Schema Information
#
# Table name: groupings
#
#  id         :integer          not null, primary key
#  contact_id :integer          not null
#  group_id   :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Grouping < ActiveRecord::Base
  belongs_to :contact
  belongs_to :group
end

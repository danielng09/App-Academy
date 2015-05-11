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

require 'test_helper'

class GroupingTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

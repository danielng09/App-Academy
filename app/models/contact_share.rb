# == Schema Information
#
# Table name: contact_shares
#
#  id         :integer          not null, primary key
#  contact_id :integer          not null
#  user_id    :integer          not null
#

class ContactShare < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact
end

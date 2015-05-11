# == Schema Information
#
# Table name: contacts
#
#  id         :integer          not null, primary key
#  user_id    :integer          not null
#  name       :string           not null
#  email      :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class Contact < ActiveRecord::Base
  belongs_to :user
  has_many :contact_shares
  has_many :shared_users, through: :contact_shares, source: :user
  has_many :favorites, dependent: :destroy
  has_many :comments, as: :commentable
  validates :user_id, :name, :email, presence: true
  validates :email, uniqueness: { scope: :user_id }

end

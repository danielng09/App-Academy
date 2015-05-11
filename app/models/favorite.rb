class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :contact

  validates :contact, uniqueness: scope: { :user_id }
end

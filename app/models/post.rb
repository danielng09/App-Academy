# == Schema Information
#
# Table name: posts
#
#  id         :integer          not null, primary key
#  title      :string           not null
#  url        :string           not null
#  content    :text             not null
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ActiveRecord::Base
  validates :title, :url, :content, :author_id, presence: true
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :post_subs
  has_many :subs, through: :post_subs, source: :sub
  has_many :comments

  def comments_by_parent_id
    comments_by_parent = Hash.new { |h, k| h[k] = [] }

    self.comments.includes(:author).each do |comment|
      comments_by_parent[comment.parent_comment_id] << comment
    end
    comments_by_parent
  end
end

class AddTagTopicIdToShortenedUrls < ActiveRecord::Migration
  def change
    add_column :shortened_urls, :tag_topic_id, :integer
  end
end

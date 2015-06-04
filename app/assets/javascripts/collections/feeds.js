NewsReader.Collections.Feeds = Backbone.Collection.extend({
  model: NewsReader.Models.Feed,
  url: '/api/feeds',

  getOrFetch: function (id) {
    var feeds = this;
    var feed = this.get(id);
    if ( feed ) {
      feed.fetch();
    } else {
      feed = new NewsReader.Models.Feed({ id: id });
      feed.fetch({
        success: function (model) {
          feeds.add(model);
        }
      });
    }

    return feed;
  }
});

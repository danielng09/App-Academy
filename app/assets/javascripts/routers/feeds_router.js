NewsReader.Routers.FeedsRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'index',
    'feeds/:id': 'feedShow'
  },

  index: function () {
    NewsReader.feeds.fetch();
    var view = new NewsReader.Views.FeedsIndex ({
      collection: NewsReader.feeds,
      $rootEl: $('#sidebar')
    });
    this.$rootEl.html(view.render().$el);
  },

  feedShow: function (id) {
    var feed = NewsReader.feeds.getOrFetch(id);
    var view = new NewsReader.Views.FeedShow ({
      model: feed
    });

    this.$rootEl.html(view.render().$el);
  }
});

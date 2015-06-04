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
      collection: NewsReader.feeds
    });
    this.$rootEl.html(view.render().$el);
  },

  feedShow: function (id) {
    this.$rootEl.html('<script>alert('+ id + ')</script>');
  }
});

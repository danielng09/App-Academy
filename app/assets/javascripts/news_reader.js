window.NewsReader = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function () {
    var $rootEl = $('#content');
    NewsReader.feeds = new NewsReader.Collections.Feeds ();
    NewsReader.feeds.fetch({ reset: true });
    new NewsReader.Routers.FeedsRouter ({
      $rootEl: $rootEl
    });
    Backbone.history.start();
  }
};

$(document).ready(function(){
  NewsReader.initialize();
});

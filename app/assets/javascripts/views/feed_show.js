NewsReader.Views.FeedShow = Backbone.View.extend({
  template: JST['feeds/show'],
  events: {
    'click .refresh-button': 'refreshFeed'
  },

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);

    var currentView = this;

    this.model.entries().each(function (entry) {
      var entryView = new NewsReader.Views.FeedShowItem({
        model: entry
      });
      currentView.$el.find('.entry-list').append(entryView.render().$el);
    });

    return this;
  },

  refreshFeed: function (event) {
    event.preventDefault();
    this.model.fetch();
    this.$el.append("<script>alert('refreshing...')</script>");
  }

});

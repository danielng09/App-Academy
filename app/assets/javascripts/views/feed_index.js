NewsReader.Views.FeedsIndex = Backbone.View.extend({
  template: JST['feeds/index'],

  initialize: function (options) {
    this.$el = options.$rootEl;
    this.listenTo(this.collection, 'sync remove add', this.render);
  },

  render: function () {
    var content = this.template;
    this.$el.html(content);
    this.collection.each(function (feed) {
      var indexItem = new NewsReader.Views.FeedIndexItem({
        model: feed
      });
      this.$('.feed-list').append(indexItem.render().$el);
    }.bind(this));

    return this;
  }

});

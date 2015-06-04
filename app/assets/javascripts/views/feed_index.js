NewsReader.Views.FeedsIndex = Backbone.View.extend({
  template: JST['feeds/index'],

  initialize: function () {
    this.listenTo(this.collection, 'sync', this.render);
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

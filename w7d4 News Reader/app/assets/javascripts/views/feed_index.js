NewsReader.Views.FeedsIndex = Backbone.CompositeView.extend({
  template: JST['feeds/index'],

  initialize: function (options) {
    this.$el = $($.find('#sidebar'));
    this.listenTo(this.collection, 'add', this.addFeedIndexItemView);
    this.listenTo(this.collection, 'sync add', this.render);

    this.collection.each(function (feed) {
      this.addFeedIndexItemView(feed);
    }.bind(this));
  },

  addFeedIndexItemView: function (feed) {
    event.preventDefault();
    var subview = new NewsReader.Views.FeedIndexItem({ model: feed });
    this.addSubview('.feed-list', subview);
  },

  render: function () {
    var content = this.template();
    this.$el.html(content);

    this.attachSubviews();
    return this;
  }

});

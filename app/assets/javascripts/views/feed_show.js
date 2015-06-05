NewsReader.Views.FeedShow = Backbone.CompositeView.extend({
  template: JST['feeds/show'],
  events: {
    'click .refresh-button': 'refreshFeed'
  },

  initialize: function () {
    this.collection = this.model.entries();
    this.listenTo(this.model, 'sync', this.render);
    this.listenTo(this.collection, 'add', this.addEntryView);
    this.collection.each(this.addEntryView.bind(this));
  },

  addEntryView: function (entry) {
    var subview = new NewsReader.Views.Entry({ model: entry });
    this.addSubview('.entry-list', subview);
  },

  render: function () {
    var content = this.template({ feed: this.model });
    this.$el.html(content);
    this.attachSubviews();

    return this;
  },

  refreshFeed: function (event) {
    this.model.fetch();
  }

});

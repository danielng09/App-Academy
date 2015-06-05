NewsReader.Views.FeedIndexItem = Backbone.View.extend({
  tagName: 'li',
  className: 'list-group-item',

  events: {
    "click .delete-feed": "destroyIndexItem"
  },

  template: JST['feeds/indexItem'],

  initialize: function () {
    this.listenTo(this.model, 'sync destroy', this.render);
  },

  render: function () {
    var content = this.template({
      feed: this.model
    });

    this.$el.html(content);

    return this;
  },

  destroyIndexItem: function (event) {
    event.preventDefault();
    console.log("in the destroyIndexItem function");
    this.model.destroy();
  }

});

JournalApp.Views.PostsIndexItem = Backbone.View.extend({
  template: JST['posts_index_item'],

  tagName: "li",
  events: {
    "click button": "delete"
  },

  initialize: function () {
  },

  delete: function () {
    this.model.destroy();
    this.remove();
  },

  render: function () {
    this.$el.html(this.template({ post: this.model }));

    return this;
  }
});

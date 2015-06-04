JournalApp.Views.PostsIndexItem = Backbone.View.extend({
  template: JST['posts_index_item'],
  tagName: "li",
  events: {
    "click .posts-delete": "delete",
    "click .posts-edit": "edit"
  },

  initialize: function () {
  },

  delete: function () {
    this.model.destroy();
    this.remove();
  },

  edit: function () {
    event.preventDefault();
    Backbone.history.navigate(this.model.url() + "/edit", { trigger: true });
  },

  render: function () {
    this.$el.html(this.template({ post: this.model }));

    return this;
  }
});

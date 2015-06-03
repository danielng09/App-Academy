JournalApp.Routers.Posts = Backbone.Router.extend({

  initialize: function (options) {
    this.$el = $(options.el);
    this.posts = options.posts;

  },

  routes: {
    "": "index",
    "posts/:id": "show"
  },

  index: function () {
    JournalApp.postsIndex = new JournalApp.Views.PostsIndex({
                              el: this.$el,
                              collection: this.posts});
    this.posts.fetch({ reset: true });
  },

  show: function (id) {
    var post  = this.posts.getOrFetch(id);
    var view = new JournalApp.Views.PostShow({ model: post });
    this.$el.html(view.render().$el);
  }
});

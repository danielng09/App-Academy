JournalApp.Routers.Posts = Backbone.Router.extend({

  initialize: function (options) {
    this.$el = $(options.el);
    this.posts = options.posts;
  },

  routes: {
    "": "index",
    "posts/new": "new",
    "posts/:id": "show",
    "posts/:id/edit": "update"
  },
  new: function () {
    var post = new JournalApp.Models.Posts();
    var view = new JournalApp.Views.PostForm({ model: post, collection: this.posts });
    this.$el.html(view.render().$el);
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
  },

  update: function (id) {
    var post  = this.posts.getOrFetch(id);
    var view = new JournalApp.Views.PostForm({ model: post });
    this.$el.html(view.render().$el);
  }
});

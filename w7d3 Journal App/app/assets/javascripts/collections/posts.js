JournalApp.Collections.Posts = Backbone.Collection.extend({
  model: JournalApp.Models.Posts,
  url: "posts",

  getOrFetch: function (id) {
    var collection = this;
    var post = collection.get(id);
    if (post) {
      post.fetch();
    } else {
      post = new JournalApp.Models.Posts({ id: id });
      post.fetch({
        success: function () {
          collection.add(post);
        }
      });
    }

    return post;
  }
});

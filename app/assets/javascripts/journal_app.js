window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {}
};

$(document).ready(function(){
  var $rootEl = $('.journal-app');
  var postsCollection = new JournalApp.Collections.Posts();
  postsCollection.fetch();
  // window.JournalApp.posts = new JournalApp.Collections.Posts();
  // window.JournalApp.postsIndex = new JournalApp.Views.PostsIndex({ el: $rootEl, collection: window.JournalApp.posts});
  // window.JournalApp.posts.fetch({ reset: true });
  window.JournalApp.postRouter = new JournalApp.Routers.Posts({
                                    el: $rootEl,
                                    posts: postsCollection
                                  });

  Backbone.history.start();
});

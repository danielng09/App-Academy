window.JournalApp = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {}
};

$(document).ready(function(){
  var $rootEl = $('.journal-app');
  window.JournalApp.posts = new JournalApp.Collections.Posts();
  window.JournalApp.postsIndex = new JournalApp.Views.PostsIndex({ $el: $rootEl, collection: window.JournalApp.posts});
  window.JournalApp.posts.fetch({ reset: true });
});

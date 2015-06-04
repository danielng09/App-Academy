NewsReader.Collections.Entries = Backbone.Collection.extend({
  model: NewsReader.Models.Entry,
  url: this.feed() + '/entries'
});

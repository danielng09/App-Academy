NewsReader.Models.Entry = Backbone.Model.extend({
  urlRoot: this.feed.url() + "/entries"
});

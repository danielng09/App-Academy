NewsReader.Views.FeedShowItem = Backbone.View.extend({
  template: JST['feeds/showItem'],

  initialize: function () {
    this.listenTo(this.model, 'sync', this.render);
  },

  render: function () {
    var content = this.template({ entry: this.model });
    this.$el.html(content);

    return this;
  }

});

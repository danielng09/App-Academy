TrelloClone.Views.BoardIndexItem = Backbone.View.extend({
  tagName: 'li',
  className: 'list-group-item list-group-item-info',
  template: JST['boards/index_item'],
  events: {
    "click button.delete-board": "deleteBoard"
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  },

  deleteBoard: function (event) {
    event.preventDefault();
    this.model.destroy();
  }

});

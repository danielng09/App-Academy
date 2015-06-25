TrelloClone.Views.NewList = Backbone.View.extend({
  className: 'list new-list',
  events: {
    'submit .new-list': 'postList'
  },

  template: JST['lists/new'],

  render: function () {
    var content = this.template({ list: this.model });
    this.$el.html(content);
    return this;
  },

  postList: function (event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON().board;
    formData.board_id = this.collection.board.id;
    var newList = new TrelloClone.Models.List(formData);
    newList.save({}, {
      success: function () {
        this.collection.add(newList);
      }.bind(this)
    });
  }

});

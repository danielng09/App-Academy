TrelloClone.Views.BoardNew = Backbone.View.extend({
  className: 'new-board',
  events: {
    'click button': 'postBoard'
  },

  template: JST['boards/new'],

  render: function () {
    var content = this.template({ list: this.model });
    this.$el.html(content);
    return this;
  },

  postBoard: function (event) {
    event.preventDefault();
    var newTitle = this.$el.find('input').val();
    var newBoard = new TrelloClone.Models.Board({ title: newTitle });

    newBoard.save({}, {
      success: function () {
        this.collection.add(newBoard);
        Backbone.history.navigate("#/boards/" + newBoard.get('id'));
      }.bind(this)
    });
  }

});

TrelloClone.Collections.Boards = Backbone.Collection.extend({
  url: '/api/boards',
  model: TrelloClone.Models.Board,

  getOrFetch: function (id) {
    var boardMaybe = this.get(id);

    if (!boardMaybe) {
      boardMaybe = new TrelloClone.Models.Board({ id: id});
      boardMaybe.fetch({
        success: function () {
          this.add(boardMaybe);
        }.bind(this)
      });
    } else {
      boardMaybe.fetch();
    }

    return boardMaybe;
  }
});

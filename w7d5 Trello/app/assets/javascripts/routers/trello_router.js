TrelloClone.Routers.TrelloRouter = Backbone.Router.extend({
  initialize: function (options) {
    this.boards = options.boards;
    this.$rootEl = options.$rootEl;
  },

  routes: {
    '': 'boardsIndex',
    'boards/:id': 'showBoard'
  },

  showBoard: function (id) {
    var board = this.boards.getOrFetch(id);
    var showBoardView = new TrelloClone.Views.BoardShow({ model: board });

    this._swapView(showBoardView);
  },

  boardsIndex: function () {
    var indexView = new TrelloClone.Views.BoardsIndex({ collection: this.boards });
    this._swapView(indexView);
  },

  _swapView: function (view) {
    if (this._currentView) {
      this._currentView.remove();
    }

    this._currentView = view;
    this.$rootEl.html(view.render().$el);
  }

});

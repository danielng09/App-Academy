window.TrelloClone = {
  Models: {},
  Collections: {},
  Views: {},
  Routers: {},
  initialize: function () {
    var boards = new TrelloClone.Collections.Boards();
    boards.fetch();
    var $rootEl = $('#main');

    new TrelloClone.Routers.TrelloRouter({ boards: boards, $rootEl: $rootEl});
    Backbone.history.start();
  }
};

$(document).ready(function(){
  TrelloClone.initialize();
});

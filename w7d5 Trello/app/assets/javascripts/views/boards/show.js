TrelloClone.Views.BoardShow = Backbone.CompositeView.extend({
  className: "board",
  template: JST['boards/show'],

  initialize: function (options) {
    this.model.lists().board = options.model;
    this.listenTo(this.model.lists(), 'add', this.addListSubview);
    this.listenTo(this.model.lists(), 'remove', this.removeListSubview);
    this.listenTo(this.model, 'sync', this.render);

    this.model.lists().each(function (list) {
      this.addListSubview(list);
    }.bind(this));

    var newListForm = new TrelloClone.Views.NewList({ collection: this.model.lists() });
    this.addSubview('div.new-list-form', newListForm);
  },

  addListSubview: function (list) {
    var listView = new TrelloClone.Views.ListShow({
      model: list
    });

    this.addSubview('div.board-list-group', listView);

  },

  removeListSubview: function (list) {
    this.removeModelSubview('div.board-list-group', list);
  },

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);

    this.attachSubviews();

    var board = this;
    $( "#list-sortable" ).sortable({
      connectWith: "div"
    });


    $( "#list-sortable" ).disableSelection();

    $( "#card-sortable" ).sortable({
      connectWith: "div",

    });

    $( "#card-sortable" ).disableSelection();

    $( "#card-sortable, #list-sortable" ).sortable({
      connectWith: ".connectedSortable",
      update: function (ele) {
        var orderOfLists = $(ele.target).children().toArray().map(function(ele) {
          return $(ele).data('id');
        });
        var lists = board.model.lists();
        for (var i = 0; i < orderOfLists.length; i++) {
          var list = lists.at(i);
          var newOrd = orderOfLists.indexOf(list.id);
          list.set({
            "ord": newOrd
          });
          list.save();
        }
      }
    }).disableSelection();

    return this;
  }

});

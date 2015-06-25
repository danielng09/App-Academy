TrelloClone.Views.ListShow = Backbone.CompositeView.extend({
  tagName: 'div',
  className: 'list',

  events: {
    "click button.delete-list": "deleteList"
  },

  template: JST['lists/show'],

  initialize: function (options) {
    this.$el.attr("data-id", this.model.id);
    this.model.cards().list = this.model;
    this.listenTo(this.model.cards(), 'add', this.addCardSubview);
    this.listenTo(this.model.cards(), 'remove', this.removeCardSubview);
    this.listenTo(this.model.cards(), 'sync', this.render);

    this.model.cards().each(function (card) {
      this.addCardSubview(card);
    }.bind(this));

    var newCardForm = new TrelloClone.Views.CardNew({ collection: this.model.cards() });
    this.addSubview('div.new-card-form', newCardForm);
  },


  render: function () {
    var content = this.template({ list: this.model });
    this.$el.html(content);

    this.attachSubviews();

    return this;
  },

  deleteList: function (event) {
    event.preventDefault();
    this.model.destroy();
  },

  addCardSubview: function (card) {
    var cardView = new TrelloClone.Views.CardShow({
      model: card
    });

    this.addSubview('div.card-list', cardView);
  },

  removeCardSubview: function (card) {
    this.removeModelSubview('div.card-list', card);
  }

});

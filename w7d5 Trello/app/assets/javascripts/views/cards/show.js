TrelloClone.Views.CardShow = Backbone.View.extend({
  template: JST['cards/show'],
  className: "card",
  events: {
    'click button.delete-card': "deleteCard"
  },

  initialize: function (options) {
    this.$el.attr("data-id", this.model.id);
  },

  render: function () {
    var content = this.template({ card: this.model });
    this.$el.html(content);

    return this;
  },

  deleteCard: function (event) {
    event.preventDefault();
    this.model.destroy();
  }

});

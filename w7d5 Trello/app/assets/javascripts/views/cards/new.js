TrelloClone.Views.CardNew = Backbone.View.extend({
  className: 'new-card',
  events: {
    'submit .new-card': 'postCard'
  },

  template: JST['cards/new'],

  render: function () {
    var content = this.template({ board: this.model });
    this.$el.html(content);
    return this;
  },

  postCard: function (event) {
    event.preventDefault();
    var formData = $(event.currentTarget).serializeJSON().board;
    formData.list_id = this.collection.list.id;
    var newCard = new TrelloClone.Models.Card(formData);
    newCard.save({}, {
      success: function () {
        this.collection.add(newCard);
      }.bind(this)
    });
  }
});

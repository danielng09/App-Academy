JournalApp.Views.PostForm = Backbone.View.extend({
  template: JST['post_form'],
  events: {
    'click button': 'update'
  },

  update: function (event) {
    event.preventDefault();
    var formData = this.$el.find('form').serializeJSON();
    this.model.save(formData.post, {
      success: function () {
        Backbone.history.navigate("/#", { trigger: true });
      },
      error: function (model, resp, options) {
        console.log(resp);
      }
    });

  },

  render: function () {
    var content = this.template({ post: this.model });
    this.$el.html(content);

    return this;
  }
});

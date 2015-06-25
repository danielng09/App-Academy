Pokedex.Views = {}

Pokedex.Views.PokemonIndex = Backbone.View.extend({
  events: {
    'click li': "selectPokemonFromList"
  },

  initialize: function (options) {
    this.listenTo(this.collection, "sync add", this.render);

  },

  addPokemonToList: function (pokemon) {
    var content = JST['pokemonListItem']({pokemon: pokemon});
    this.$el.append(content);
  },

  refreshPokemon: function (options) {
    this.collection.fetch();

    return this.collection;
  },

  render: function () {
    this.$el.empty();
    this.collection.each(this.addPokemonToList.bind(this));
  },

  selectPokemonFromList: function (event) {
    var $target = $(event.currentTarget);
    var pokemon = this.collection.get($target.data('id'));


    var pokemonDetail = new Pokedex.Views.PokemonDetail({
      model: pokemon,
      collection: this.collection
    });

    $("#pokedex .pokemon-detail").html(pokemonDetail.$el);
    pokemonDetail.refreshPokemon();
  }
});

Pokedex.Views.PokemonDetail = Backbone.View.extend({
  events: {
    'click .toys li': "selectToyFromList"
  },

  refreshPokemon: function (options) {
    var that = this;
    this.model.fetch({
      success: (function() {
        that.render();
      })
    });
  },

  render: function () {
    var content = JST['pokemonDetail']({pokemon: this.model});
    this.$el.html(content);
    var that = this;
    this.model.toys().each(function(toy) {
      var toyContent = JST['toyListItem']({ toy: toy });
      that.$el.find('.toys').append(toyContent);
    });


  },

  selectToyFromList: function (event) {
    var toyId = $(event.currentTarget).data('id');
    var toy = this.model.toys().get(toyId);
    var toyDetail = new Pokedex.Views.ToyDetail({
      model: toy,
      collection: this.collection
    });

    toyDetail.render();
    $("#pokedex .toy-detail").html(toyDetail.$el);
  }
});

Pokedex.Views.ToyDetail = Backbone.View.extend({
  render: function () {
    var content = JST['toyDetail']({ toy: this.model, pokes: this.collection  });
    this.$el.html(content)
  }
});


$(function () {
  var pokemons = new Pokedex.Collections.Pokemon();
  var pokemonIndex = new Pokedex.Views.PokemonIndex({
    collection: pokemons
  });
  pokemonIndex.refreshPokemon();
  $("#pokedex .pokemon-list").html(pokemonIndex.$el);
});

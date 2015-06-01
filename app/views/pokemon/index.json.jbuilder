# json.pokemon do
#   json.id @pokemon.id
#   json.attack @pokemon.attack
#   json.defense @pokemon.defense
#   json.image_url @pokemon.image_url
#   json.moves @pokemon.moves
#   json.name @pokemon.name
#   json.poke_type @pokemon.poke_type
# end

# json.pokemons do
#     json.array!(:id, :attack, :defense, :image_url, :moves, :name, :poke_type)
# end

json.array!(@pokemon, partial: 'pokemon/pokemon', as: :pokemon)

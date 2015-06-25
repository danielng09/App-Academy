json.(@board, :id, :title, :user_id)

json.members @board.members do |member|
  json.id member.id
  json.email member.email
end

json.lists @board.lists do |list|
  json.id list.id
  json.title list.title
  json.ord list.ord
  json.cards list.cards do |card|
    json.id card.id
    json.title card.title
    json.description card.description
    json.ord card.ord
  end
end

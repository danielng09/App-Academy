# User.destroy_all
# Sub.destroy_all

User.create!(email: "admin@gmail.com", password: "password")
User.create!(email: "sports@gmail.com", password: "password")

Sub.create!(title: "Sports", description: "Sports description", moderator_id: 1)
Sub.create!(title: "Tv Shows", description: "TV descriptions", moderator_id: 1)
Sub.create!(title: "News", description: "News description", moderator_id: 1)

Post.create!(title: "Bull lose semi-finals", url: "www.yahoo.com", content: "Took place in chicago", sub_id: 1, author_id: 1)
Post.create!(title: "Cavs win semi-finals", url: "www.yahoo.com", content: "something", sub_id: 1, author_id: 2)
Post.create!(title: "Curry wins the MVP", url: "www.yahoo.com", content: "happened sometime last week", sub_id: 1, author_id: 1)

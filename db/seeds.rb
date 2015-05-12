# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create!(name: 'Alfred')
  Contact.create!(user_id: 1, name: 'John', email: '2@2.2')
  Contact.create!(user_id: 1, name: 'Bobby', email: '4@4.4')
  Contact.create!(user_id: 1, name: 'Tommy', email: 't@t.2')
  ContactShare.create!(contact_id: 1, user_id: 2)
  Favorite.create!(user_id: 1, contact_id: 1)
  Group.create!(user_id: 1, group_name: "Friends")
    Grouping.create(contact_id: 1, group_id: 1)
    Grouping.create(contact_id: 2, group_id: 1)
  Group.create!(user_id: 1, group_name: "Enemies")
    Grouping.create(contact_id: 3, group_id: 2)


User.create!(name: 'Bruce')
  Contact.create!(user_id: 2, name: 'Mom', email: '3@3.3')

User.create!(name: 'Peter')

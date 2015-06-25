#users
names = ['bobby','carl','daniel','tommy','joe']
names.each do |fname|
  User.create!(name: fname)
end

#polls
Poll.create(user_id: 1, title: "Poll #1")

#questions
qbodies = ['what is your color?', 'would you like coffee?', 'what is your hobby?']
qbodies.each do |quest|
  Question.create(body: quest, poll_id: 1)
end

#answer_choices
poss_choices1 = ['green','blue','yellow','red']
poss_choices1.each do |choice|
  AnswerChoice.create(body: choice, question_id: 1)
end

poss_choices2 = ['yes','no']
poss_choices2.each do |choice|
  AnswerChoice.create(body: choice, question_id: 2)
end

poss_choices3 = ['running','tv','eating']
poss_choices3.each do |choice|
  AnswerChoice.create(body: choice, question_id: 3)
end

#responses
Response.create(user_id: 1, answer_choice_id: 1)
Response.create(user_id: 2, answer_choice_id: 1)
Response.create(user_id: 3, answer_choice_id: 1)
Response.create(user_id: 4, answer_choice_id: 2)
Response.create(user_id: 5, answer_choice_id: 3)

require 'sqlite3'
require 'Singleton'
require_relative 'user'
require_relative 'question'
require_relative 'question_follow'
require_relative 'question_like'
require_relative 'reply'

class QuestionsDatabase < SQLite3::Database
  include Singleton

  def initialize
    super('questions.db')
    self.results_as_hash = true
    self.type_translation = true
  end

  def self.execute(*arg, &blk)
    self.instance.execute(*arg, &blk)
  end

  def self.get_first_row(*arg, &blk)
    self.instance.get_first_row(*arg, &blk)
  end
end



  # EASY QUERY CHECKS
# print Question.find_by_author_id(1)
# blah = Question.all
# p blah
# p Reply.find_by_question_id(1)
# reply = Reply.find_by_id(2)
# user = User.find_by_name("Daniel", "Ng")
# p user
# p user.authored_questions
# p user.authored_replies
# question = Question.find_by_id(1)
# p question.author
# p question.replies
# p reply.author
# p reply.question
# p reply.parent_reply
# reply_2 = Reply.find_by_id(1)
# p reply_2.child_replies

  # MEDIUM QUERY CHECKS
# p QuestionFollow.followers_for_question_id(1)
# p QuestionFollow.followed_questions_for_user_id(1)
# p QuestionFollow.followed_questions_for_user_id(2)
# p User.find_by_id(1).followed_questions
# p QuestionFollow.followers_for_question_id(1)

  # HARD QUERY CHECKS
# p QuestionFollow.most_followed_questions(1)
# p QuestionLike.likers_for_question_id(2)
# p QuestionLike.num_likes_for_question_id(2)
# p QuestionLike.liked_questions_for_user_id(1)
# p QuestionLike.most_liked_questions(4)
# p User.find_by_id(2).average_karma

User.new("fname" => "Hugh", "lname" => "Jackman").save
results = QuestionsDatabase.execute(<<-SQL)

  SELECT
    *
  FROM
    users
  SQL
print results

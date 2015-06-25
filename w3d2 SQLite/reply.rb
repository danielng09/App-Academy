# require_relative 'questionsdatabase'

class Reply
  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        replies
    SQL
    results.map { |result| self.new(result)}
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = ?;
    SQL
    self.new(results)
  end

  def self.find_by_user_id(user_id)
    results = QuestionsDatabase.get_first_row(<<-SQL, user_id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.user_id = ?;
    SQL
    self.new(results)
  end

  def self.find_by_question_id(id)
    results = QuestionsDatabase.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.question_id = ?;
    SQL
    self.new(results)
  end


  attr_reader :id, :question_id, :parent_id, :user_id, :body

  def initialize(options = {})
    @id = options["id"]
    @question_id = options["question_id"]
    @parent_id = options["parent_id"]
    @user_id = options["user_id"]
    @body = options["body"]
  end

  def author
    User.find_by_id(@user_id)
  end

  def question
    Question.find_by_id(@question_id)
  end

  def parent_reply
    Reply.find_by_id(@parent_id)
  end

  def child_replies
    children = Array.new
    Question.find_by_id(@question_id).replies.each do |reply|
      children << reply if reply.parent_id == @id
    end
    children
  end
end

# require_relative 'questionsdatabase'

class Question
  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        questions;
    SQL
    results.map { |result| Question.new(result)}
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.get_first_row(<<-SQL, question_id: id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = :question_id;
    SQL
    self.new(results)
  end

  def self.find_by_author_id(author_id)
    results = QuestionsDatabase.execute(<<-SQL, author_id: author_id)
      SELECT DISTINCT
        *
      FROM
        questions
      WHERE
        questions.user_id = :author_id
    SQL
    results.map { |result| Question.new(result)}
  end

  attr_reader :id, :question_id, :title, :body, :user_id

  def initialize(options = {})
    @id = options["id"]
    @question_id = options["question_id"]
    @title = options["title"]
    @body = options["body"]
    @user_id = options["user_id"]
  end

  def author
    User.find_by_id(@user_id)
  end

  def replies
    all_replies = Reply.all
    all_replies.select { |reply| reply.question_id == @id }
  end

end

require_relative 'questionsdatabase'
class Question
  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        questions;
    SQL
    results.map { |result| self.new(result)}
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.get_first_row(<<-SQL, question_id: id)
      SELECT
        *
      FROM
        questions
      WHERE
        questions.id = :question_id;
    SQL
    self.new(results)
  end

  attr_reader :id, :title, :body, :user_id

  def initialize(options = {})
    @id = options[id]
    @title = options[title]
    @body = options[body]
    @user_id = options[user_id]
  end

end

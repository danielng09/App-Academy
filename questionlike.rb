require_relative 'questionsdatabase'
class QuestionLike
  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        question_likes
    SQL
    results.map { |result| self.new(result)}
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_likes.id = ?;
    SQL
    self.new(results)
  end

  attr_reader :id, :user_id, :question_id

  def initialize(options = {})
    @id = options[id]
    @user_id = options[user_id]
    @question_id = options[question_id]
  end

end

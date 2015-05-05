# require_relative 'questionsdatabase'

class QuestionFollow
  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        question_follows;
    SQL
    results.map { |result| QuestionFollow.new(result)}
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        question_follows
      WHERE
        question_follows.id = ?;
    SQL
    self.new(results)
  end

  attr_reader :id, :question_id, :user_id

  def initialize(options = {})
    @id = options["id"]
    @question_id = options["question_id"]
    @user_id = options["user_id"]
  end

end

# blah = QuestionFollow.all
# p blah
# er = QuestionFollow.find_by_id(1).class
# p er

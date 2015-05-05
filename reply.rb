require_relative 'questionsdatabase'
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
    results = QuestionsDatabase.instance.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        replies
      WHERE
        replies.id = ?;
    SQL
    self.new(results)
  end

  attr_reader :id, :question_id, :parent_id, :user_id, :body

  def initialize(options = {})
    @id = options[id]
    @question_id = options[question_id]
    @parent_id = options[parent_id]
    @user_id = options[user_id]
    @body = options[body]
  end

end

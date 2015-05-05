require_relative 'questionsdatabase'
class User
  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        users
    SQL
    results.map { |result| Users.new(result)}
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.instance.get_first_row(<<-SQL, user_id: id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = :user_id;
    SQL
    User.new(results)
  end

  attr_reader :id, :fname, :lname

  def initialize(options = {})
    @id = options[id]
    @fname = options[fname]
    @lname = options[lname]
  end
end

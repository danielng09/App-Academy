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

  def self.followers_for_question_id(question_id)
    results = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id IN (
          SELECT
            user_id
          FROM
            question_follows
          WHERE
            question_id = ?
          );
    SQL
    results.map { |result| User.new(result)}
  end

  def self.followed_questions_for_user_id(user_id)
    results = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        q.id, q.title, q.body, q.user_id
      FROM
        users AS u
      INNER JOIN
        question_follows AS qf ON u.id = qf.user_id
      INNER JOIN
        questions AS q ON q.id = qf.question_id
      WHERE
        u.id = ?;
    SQL
    results.map { |result| Question.new(result)}
  end

  def self.most_followed_questions(n)
    results = QuestionsDatabse.execute(<<-SQL, n)
      SELECT
        question_id
      FROM
        question_follows
      GROUP BY
        question_id
      ORDER BY
        COUNT(user_id)
      LIMIT
        ?
    SQL
    print results
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

# require_relative 'questionsdatabase'

class User
  def self.all
    results = QuestionsDatabase.execute(<<-SQL)
      SELECT
        *
      FROM
        users
    SQL
    results.map { |result| User.new(result)}
  end

  def self.find_by_id(id)
    results = QuestionsDatabase.get_first_row(<<-SQL, user_id: id)
      SELECT
        *
      FROM
        users
      WHERE
        users.id = :user_id;
    SQL
    User.new(results)
  end

  def self.find_by_name(fname, lname)
    results = QuestionsDatabase.get_first_row(<<-SQL, fname, lname)
      SELECT
        *
      FROM
        users
      WHERE
        users.fname = ? AND users.lname = ?;
    SQL
    User.new(results)
  end

  attr_reader :id, :fname, :lname

  def initialize(options = {})
    @id = options["id"]
    @fname = options["fname"]
    @lname = options["lname"]
  end

  def authored_questions
    Question.find_by_author_id(@id)
  end

  def authored_replies
    Reply.find_by_user_id(@id)
  end

  def followed_questions
    QuestionFollow.followed_questions_for_user_id(@id)
  end

  def liked_questions
    QuestionLike.liked_questions_for_user_id(@id)
  end

  def average_karma
    results = QuestionsDatabase.execute(<<-SQL, @id)
      SELECT
        CAST(COUNT(ql.user_id) AS FLOAT)/
        COUNT(DISTINCT(q.id)) AS average_karma
      FROM
        questions AS q
      LEFT OUTER JOIN
        question_likes as ql ON q.id = ql.question_id
      WHERE
        q.user_id = ?
    SQL
    results.first['average_karma']
  end

  def save
    if @id
      QuestionsDatabase.execute(<<-SQL, id: @id, fn: @fname, ln: @lname)
        UPDATE
          users
        SET
          fname = :fn,
          lname = :ln
        WHERE
          id = :id;
      SQL

    else
      QuestionsDatabase.execute(<<-SQL, @fname, @lname)
        INSERT INTO
          users (fname, lname)
        VALUES
          (?, ?)
      SQL
    end

    @id = QuestionsDatabase.instance.last_insert_row_id
    self
  end
end

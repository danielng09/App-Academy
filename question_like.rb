# require_relative 'questionsdatabase'

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
    results = QuestionsDatabase.get_first_row(<<-SQL, id)
      SELECT
        *
      FROM
        question_likes
      WHERE
        question_likes.id = ?;
    SQL
    self.new(results)
  end

  def self.likers_for_question_id(question_id)
    results = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        u.id, u.fname, u.lname
      FROM
        question_likes as ql
      JOIN
        users as u ON u.id = ql.user_id
      WHERE
        ql.question_id = ?
    SQL
    results.map { |result| User.new(result) }
  end

  def self.num_likes_for_question_id(question_id)
    results = QuestionsDatabase.execute(<<-SQL, question_id)
      SELECT
        COUNT(*) as count
      FROM
        question_likes as ql
      WHERE
        ql.question_id = ?
    SQL
    results.first["count"]
  end

  def self.liked_questions_for_user_id(user_id)
    results = QuestionsDatabase.execute(<<-SQL, user_id)
      SELECT
        q.id, q.title, q.body, q.user_id, COUNT(q.user_id)
      FROM
        questions as q
      JOIN
        question_likes as ql ON ql.question_id = q.id
      WHERE
        ql.user_id = ?;
    SQL
    results.map { |result| Question.new(result)}
  end

  def self.most_liked_questions(n)
    results = QuestionsDatabase.execute(<<-SQL, n)
      SELECT
        q.id, q.title, q.body, q.user_id
      FROM
        questions AS q
      JOIN
        question_likes AS ql ON q.id = ql.question_id
      GROUP BY
        q.id, q.title, q.body, q.user_id
      ORDER BY
        count(q.user_id) DESC
      LIMIT
        ?
    SQL
    results.map { |result| Question.new(result) }
  end

  attr_reader :id, :user_id, :question_id

  def initialize(options = {})
    @id = options["id"]
    @user_id = options["user_id"]
    @question_id = options["question_id"]
  end


end

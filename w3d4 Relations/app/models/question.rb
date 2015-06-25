class Question < ActiveRecord::Base
  validates :body, :poll_id, presence: true

  has_many(
    :answer_choices,
    class_name: 'AnswerChoice',
    foreign_key: :question_id,
    primary_key: :id
  )

  belongs_to(
    :poll,
    class_name: 'Poll',
    foreign_key: :poll_id,
    primary_key: :id
  )

  has_many(
    :responses,
    through: :answer_choices,
    source: :responses
  )

# that returns a hash of choices and counts like so:
  def n_results
    output = {}
    answer_choices.each do |answer|
      output[answer.body] = answer.responses.count
    end
    output
  end

  def results_includes
    output = {}
    answers = answer_choices.includes(:responses)
    answers.each do |answer|
      output[answer.body] = answer.responses.length
    end
    output
  end

  def results
    output = {}
    answers = answer_choices.select("answer_choices.id, answer_choices.body, COUNT(answer_choices.id) AS response_count")
    .joins(<<-SQL)
      LEFT OUTER JOIN
        responses
      ON
        responses.answer_choice_id = answer_choices.id
    SQL
    .group("answer_choices.id")

    answers.each do |answer|
      output[answer.body] = answer.response_count
    end

    output
  end
end

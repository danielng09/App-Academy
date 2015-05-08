class Response < ActiveRecord::Base
  validates :user_id, :answer_choice_id, presence: true
  validate :respondent_has_not_already_answered_question
  validate :respondent_cannot_respond_to_own_poll

  belongs_to(
    :answer_choice,
    class_name: 'AnswerChoice',
    foreign_key: :answer_choice_id,
    primary_key: :id
  )

  belongs_to(
    :respondent,
    class_name: 'User',
    foreign_key: :user_id,
    primary_key: :id
  )

  has_one(
    :question,
    through: :answer_choice,
    source: :question
  )

  def respondent_cannot_respond_to_own_poll
    if answer_choice.question.poll.user_id == user_id
      errors[:user_id] << "cannot answer your own question!"
    end
  end

  def respondent_has_not_already_answered_question
    if sibling_responses.where('responses.user_id = ?', user_id).exists?
      errors[:user_id] << 'cant answer a question twice!'
    end
  end

  def sibling_responses
    question.responses.where('responses.id != ? OR responses.id IS NOT NULL', id)
  end

end

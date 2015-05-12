# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  gender      :string           not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :gender, :description, presence: true
  validate :color_validation
  validate :gender_validation

  COLORS = [
  'Yellow',
  'Golden',
  'Black',
  'White',
  'Blue',
  'Tabby',
  'Spotted',
  'Calico'
  ]

  def age
    Time.now.year - birth_date.year
  end

  def color_validation
    unless COLORS.include?(color)
      errors[:base] << "That is not a valid color."
    end
  end

  def gender_validation
    unless gender == 'M' || gender == 'F'
      errors[:base] << "You need to pick M or F for gender."
    end
  end

end

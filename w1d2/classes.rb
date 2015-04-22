class Student
  attr_accessor :courses #List of Course objects
  attr_reader :first_name, :last_name

  def initialize(first, last)
    @first_name = first
    @last_name = last
    @courses = Array.new
  end

  def name
    "#{first_name} #{last_name}"
  end

  def course_load
    hash = {}
    courses.each do |x|
      hash[x.department] = x.credit_num
    end
    hash
  end

  def enroll(course)
    return if course.students.include?(self)
    return "Scheduling error" if has_conflict?(course)
    course.add_student(self)
    courses.push(course)
    puts name + " added " + course.course_name
    puts name + " is enrolled in " + "#{self.courses.size}" + " classes"
  end

  def has_conflict?(second_course)
    courses.each do |x|
      return true if x.conflict_with?(second_course)
    end
    false

  end
end

class Course
  attr_accessor :course_name, :department, :credit_num, :students
  attr_accessor :time_block, :days_of_our_lives

  def initialize(name, dept, credits, time_block, days_of_our_lives = {})
    defaults = {
      :mon => false,
      :tues => false,
      :wed => false,
      :thurs => false,
      :fri => false
    }
    days_of_our_lives = defaults.merge(days_of_our_lives)
    @time_block = time_block
    @course_name = name
    @department = dept
    @credit_num = credits
    @days_of_our_lives = days_of_our_lives
    @students = Array.new
  end

  def add_student(person)
    return if person.courses.include?(self)
    self.students.push(person)
    person.enroll(self)
  end

  def conflict_with?(second_course)
    if second_course.time_block == self.time_block
      second_course.days_of_our_lives.each do |key, value|
        if self.days_of_our_lives[key] == value && value == true
          return true
        end
      end
    end
    false
  end
end

# pupil = Student.new("david", "tyler")
# math = Course.new("statistics", "mathematics", 3, 1, {:mon => true, :tues => true, :wed => true})
# english = Course.new("literature", "language arts", 4, 1, { :fri => true, :mon => true})
# math.conflict_with?(english)
# pupil.enroll(math)
# var = pupil.enroll(english)

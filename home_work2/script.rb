require 'date'

class Student
  attr_accessor :name, :surname
  attr_reader :date_of_birth

  @@students = []

  def initialize(name, surname, date_of_birth)
    @name = name
    @surname = surname

    if date_of_birth > Date.today
      raise ArgumentError.new("Date of birth must be in the past")
    end
    @date_of_birth = date_of_birth
  end

  def self.students=(students)
    @students = students
  end

  def self.students
    @@students
  end

  def ==(other)
    @name == other.name && @surname == other.surname && @date_of_birth == other.date_of_birth
  end

  def calculate_age
    age = Date.today.year - date_of_birth.year

    if(Date.today.month < date_of_birth.month)
      age -= 1
    elsif(Date.today.month == date_of_birth.month &&
      Date.today.day < date_of_birth.day)
      age -= 1
    end

    age
  end

  def add_student()
    unless @@students.any? { |student| student.name == name && student.surname == surname && student.date_of_birth == date_of_birth }
      @@students << self
    end
    @@students
  end

  def remove_student()
    @@students.each do |student|
      if student.name == name && student.surname == surname && student.date_of_birth == date_of_birth
        @@students.delete(student)
      end
    end
    @@students
  end

  def self.get_students_by_age(age)
    students_by_age = []
    @@students.each{ |stud|
      p stud.calculate_age
      if stud.calculate_age == age
        students_by_age << stud
      end
    }
    students_by_age
  end

  def self.get_students_by_name(name)
    students_by_name = []
    @@students.each do |stud|
      if stud.name == name
        students_by_name << stud
      end
    end
    students_by_name
  end

end

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

  def calculate_age
    age = Date.today.year - date_of_birth.year

    if(Date.today.month < date_of_birth.month ||
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

p stud1 = Student.new('Vlad', 'Bukhinskyi', Date.new(2004, 12, 8))
p stud2 = Student.new('Vasia', 'Pupkin', Date.new(2006, 10, 18))
p stud3 = Student.new('Vlad', 'Shevchenko', Date.new(2004, 11, 30))
# p stud4 = Student.new('Gena', 'Gena', Date.new(2024, 12, 8)) #ArgumentError
p stud5 = Student.new('Vlad', 'Bukhinskyi', Date.new(2004, 12, 8))


p stud1.add_student
p stud2.add_student
# p stud5.add_student #Dublicate stud1

p stud5.remove_student

stud1.add_student
stud3.add_student

p stud1.get_students_by_age(20)

p stud1.get_students_by_name("Vasia")
p stud1.get_students_by_name("Vlad")
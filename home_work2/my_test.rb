require 'minitest/autorun'
require 'minitest/reporters'

require_relative 'script'

Minitest::Reporters.use! [
                           Minitest::Reporters::SpecReporter.new,
                           Minitest::Reporters::HtmlReporter.new(
                             reports_dir: 'test/reports',
                             # report_filename: 'test_results.html', НЕ ПРАЦЮЄ!
                             clean: true,
                             add_timestamp: true
                           )
                         ]

class MyTest < Minitest::Test

  def setup
    Student.students.clear

    @stud1 = Student.new('Vlad', 'Bukhinskyi', Date.new(2004, 12, 8))
    @stud2 = Student.new('Vasia', 'Pupkin', Date.new(2006, 10, 18))
    @stud3 = Student.new('Vlad', 'Shevchenko', Date.new(2004, 11, 3))
    @stud4 = Student.new('Gena', 'Gena', Date.new(2010, 12, 8))

    @stud1_2 = Student.new('Vlad', 'Bukhinskyi', Date.new(2004, 12, 8))
  end

  def teardown
    @stud1 = nil
    @stud2 = nil
    @stud3 = nil
    @stud4 = nil
    @stud1_2 = nil
  end

  def test_initialize
    assert_raises ArgumentError do
      Student.new("name", 'surname', Date.today+1)
    end
  end

  def test_calc_age
    assert_equal(@stud1.calculate_age, 19)
    assert_equal(@stud2.calculate_age, 18)
    assert_equal(@stud3.calculate_age, 20)
  end

  def test_add_student
    test_stud = Student.new('name', 'surname', Date.today)
    test_stud.add_student
    assert_includes Student.students, test_stud

    Student.students = nil

    @stud1.add_student
    studs = Student.students
    @stud1_2.add_student
    assert_equal Student.students, studs

    Student.students = nil
  end

  def test_remove_student
    @stud1.add_student

    assert_includes(Student.students, @stud1, "Student1 should be in the list before removal")
    @stud1.remove_student
    refute_includes(Student.students, @stud1, "Student1 should be removed from the list")
  end

  def test_get_students_by_age
    @stud1.add_student
    @stud2.add_student
    @stud3.add_student
    @stud4.add_student

    assert_includes(Student.get_students_by_age(20), @stud3)
    assert_includes(Student.get_students_by_age(19), @stud1)
  end

  def test_get_students_by_name
    @stud1.add_student
    @stud2.add_student
    @stud3.add_student
    @stud4.add_student

    assert_includes(Student.get_students_by_name("Vlad"), @stud1)
    assert_includes(Student.get_students_by_name("Vlad"), @stud3)
    assert_empty(Student.get_students_by_name("Igor"))
  end

end

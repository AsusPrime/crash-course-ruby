require 'minitest/autorun'
require 'minitest/spec'
require 'minitest/reporters'

require_relative 'script'

Minitest::Reporters.use! [
                           Minitest::Reporters::SpecReporter.new,
                           Minitest::Reporters::HtmlReporter.new(
                             reports_dir: 'test/reports',
                             # report_filename: 'test_results_spec.html', НЕ ПРАЦЮЄ!
                             clean: true,
                             add_timestamp: true
                           )
                         ]

describe Student do
  # let(:student){Student.new('Vlad', 'Bukhinskyi', Date.new(2004, 12, 8))}
  before do
    @student = Student.new('Vlad', 'Bukhinskyi', Date.new(2004, 12, 8))
    @stud2 = Student.new('Vasia', 'Pupkin', Date.new(2006, 10, 18))
    @stud3 = Student.new('Vlad', 'Shevchenko', Date.new(2004, 11, 3))
    @stud4 = Student.new('Gena', 'Gena', Date.new(2010, 12, 8))

    Student.students.clear
  end

  describe '#initialize' do
    it 'should set name, surname, and date_of_birth correctly' do
      test_student = Student.new('Ivan', 'Ivanov', Date.new(2000, 5, 20))

      _(test_student.name).must_equal 'Ivan'
      _(test_student.surname).must_equal 'Ivanov'
      _(test_student.date_of_birth).must_equal Date.new(2000, 5, 20)
    end

    it 'should raise an error if date_of_birth is in the future' do
      _(proc { Student.new('Petro', 'Petrenko', Date.today + 1) }).must_raise ArgumentError
    end
  end

  describe "#calculate age" do
    it "should correctly calculate age" do
      _(@student.calculate_age).must_equal 19
    end
  end

  describe "add_student" do
    it "should add student to \'students\' array" do
      @student.add_student
      _(Student.students).must_equal [@student]
    end

    it "shouldn't add student" do
      @student.add_student
      @student.add_student
      _(Student.students).must_equal [@student]
    end
  end

  describe "remove_student" do
    it "should remove student from \'students\' array" do
      @student.add_student

      student2 = Student.new('Vlad', 'Bukhinskyi', Date.new(2004, 12, 8))

      student2.remove_student

      _(Student.students).must_equal []

    end
  end

  describe "get students by age" do
    it "should get array of students by age" do

      @student.add_student
      @stud2.add_student
      @stud3.add_student
      @stud4.add_student

      _(Student.get_students_by_age(19)).must_equal [@student]
    end
  end

  describe "get students by name" do
    it "should get array of students by name" do

      @student.add_student
      @stud2.add_student
      @stud3.add_student
      @stud4.remove_student

      _(Student.get_students_by_name('Vlad')).must_equal [@student, @stud3]
    end
  end

end
class ScrapCoursesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    term = :first_semester
    term_mech = TermMech.new(term)
    term_mech.faculties.each do |faculty|
      faculty_mech = FacultyMech.new(term, faculty)
      faculty_mech.course_codes.each do |course_code|
        course_mech = CourseMech.new(term, course_code, faculty)
        course_mech.offerings
      end
    end
  end
end

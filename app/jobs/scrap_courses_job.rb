class ScrapCoursesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    term = :first_semester
    faculty_mech = FacultyMech.new(term, 'IC')
    faculty_mech.course_codes.each do |course_code|
      course_mech = CourseMech.new(term, course_code)
      course_mech.offerings
    end
  end
end

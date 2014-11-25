class ScrapCoursesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    term = :first_semester
    term_mech = TermMech.new(term)
    term_mech.faculties.each do |faculty|
      faculty_mech = FacultyMech.new(term, faculty)
      faculty_mech.courses.each do |course|
        course_mech = CourseMech.new(term, course)
        course_mech.room_reservations
      end
    end
  end
end

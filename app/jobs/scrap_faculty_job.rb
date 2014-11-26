class ScrapFacultyJob < ActiveJob::Base
  queue_as :default

  def perform(term, faculty)
    FacultyMech.new(term, faculty).courses.each do |course|
      ScrapCourseJob.perform_later(term, course)
    end
  end
end

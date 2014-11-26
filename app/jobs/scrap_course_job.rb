class ScrapCourseJob < ActiveJob::Base
  queue_as :default

  def perform(term, course)
    CourseMech.new(term, course).room_reservations
  end
end

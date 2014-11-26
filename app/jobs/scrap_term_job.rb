class ScrapTermJob < ActiveJob::Base
  queue_as :default

  def perform(term)
    TermMech.new(term).faculties.each do |faculty|
      ScrapFacultyJob.perform_later(term, faculty)
    end
  end
end

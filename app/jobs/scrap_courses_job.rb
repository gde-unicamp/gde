class ScrapCoursesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    agent.get(schedule_page)
    agent.page.content
  end
end

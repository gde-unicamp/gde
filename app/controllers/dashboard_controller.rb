class DashboardController < ApplicationController
  def feed
  end

  def courses
    @courses = Course.first(10)
  end
end

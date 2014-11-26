class CoursesController < ApplicationController
  def index
    @courses = Course.first(10)
  end

  def show
    @course = Course.find_by(code: params[:id])
  end
end

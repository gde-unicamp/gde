#
# A Mech to visit DAC's website and extract
# Faculty and a list of Course codes
#
class FacultyMech < GdeMech

  attr_reader :term, :faculty

  def initialize(term, faculty)
    @faculty = faculty
    @term = term
    super()
    get(dac_page)
  end

  def dac_page
    "http://www.dac.unicamp.br/sistemas/horarios/grad/#{dac_url_period_param}/#{faculty.acronym}.htm"
  end

  def courses
    @courses ||= course_codes.reduce([]) do |courses, course_code|
      course = Course.find_by(code: course_code) || Course.create!(code: course_code)
      course.update!(faculty: faculty)
      courses << course
      courses
    end
  end

  #
  # Edgecase: F_128 and similars (The real course code is F 128, but in the URL it's F_128)
  #
  def course_codes
    @course_codes ||= page.search("//a[@href!='javascript:history.go (-1)()']").map do |node| 
      node.get_attribute('href')[/\w+/].tr('_', ' ')
    end
  end
end
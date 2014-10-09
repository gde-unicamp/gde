class FacultyMech < GdeMech

  attr_reader :term, :faculty_code

  def initialize(term, faculty_code)
    @faculty_code = faculty_code
    @term = term
    super()
    get(dac_page)
  end

  def dac_page
    "http://www.dac.unicamp.br/sistemas/horarios/grad/#{dac_url_period_param}/#{faculty_code}.htm"
  end

  def dac_url_period_param
    case term
    when :first_semester
      'G1S0'
    when :second_semester
      'G2S0'
    when :summer_vacations
      'G5A0'
    end
  end

  def course_codes
    @course_codes ||= page.search("//a[@href!='javascript:history.go (-1)()']").map do |node| 
      node.get_attribute('href')[/\w+/]
    end
  end
end
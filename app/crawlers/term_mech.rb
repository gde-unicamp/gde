class TermMech < GdeMech

  attr_reader :term

  def initialize(term)
    @term = term
    super()
    get(dac_page)
  end

  def dac_page
    "http://www.dac.unicamp.br/sistemas/horarios/grad/#{dac_url_period_param}/indiceP.htm"
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

  def faculties
    @faculties ||= faculty_codes.reduce([]) do |faculties, faculty_code|
      faculty = Faculty.find_by(acronym: faculty_code) || Faculty.create!(acronym: faculty_code)
      faculty.name = extract_str("//a[contains(@href,'#{faculty_code}')]")
      faculty.save!
      faculties << faculty
    end
  end

  def faculty_codes
    @faculty_codes ||= page.search("//td[@width='3%']").map do |node|
      clean_str(node.text)
    end
  end
end
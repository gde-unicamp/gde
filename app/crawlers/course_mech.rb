class CourseMech < GdeMech

  attr_reader :term, :course_code

  def initialize(term, course_code)
    @course_code = course_code
    @term = term
    super()
    get(dac_page)
  end

  def course
    Course.where(
      code: course_code,
      title: title,
      overview: overview,
    ).first_or_create
  end

  def offerings
    (0...professors.size).map do |index|
      Offering.where(
        code: offering_codes[index],
        term: term,
        year: year,
        course: course,
        credits: credits,
        professor: professors[index],
        min_enrolled_students: min_students_required[index] || 0,
        max_enrolled_students: vacancies[index],
      ).first_or_create
    end
  end

  def professors
    @professors ||= professor_names.map do |name|
      Professor.where(name: name).first_or_create
    end
  end

  def dac_page
    "http://www.dac.unicamp.br/sistemas/horarios/grad/#{dac_url_period_param}/#{course_code}.htm"
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

  def title
    @title ||= extract_str("//a[@name='#{course_code}']/..")
  end

  def credits
    @credits ||= extract_int("//b[.='Créditos:']/../text()")
  end

  def overview
    @overview ||= extract_str("//td[@align='LEFT'][@width='600']")
  end

  def year
    @year ||= extract_int("//font[@color='#FFFFFF']/font[@size='-1']")
  end

  def offering_codes
    @offering_codes ||= (page.search("//font[@color='#990000']/..").to_a.unshift(page.at("//b[.='Turma:']/.."))).map do |node|
      clean_str(node.text[/^Turma:(.+)$/, 1])
    end
  end

  def vacancies
    @vacancies ||= page.search("//b[contains(.,'vagas')]/..").map do |node|
      node.text[/\d+/].to_i
    end
  end

  def min_students_required
    @min_students_required ||= page.search("//b[contains(.,'mínimo')]/..").map do |node|
      node.text[/\d+/].to_i
    end
  end

  def professor_names
    @professor_names ||= page.search("//b[.='Docente(s):']/../text()[2]").map do |node|
      clean_str(node.text)[/(.+)\s+\(Responsável\)/, 1]
    end
  end
end
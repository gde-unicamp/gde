#
# A Mech to visit DAC's website and extract
# Course and Offering data for a given course code and term
#
class CourseMech < GdeMech

  attr_reader :term, :course

  # Initialize variables and fetchs the course page
  #
  # @param term [Symbol] the Course offering term, `:first_semester` or `:second_semester` or `:summer_vacations`
  # @param course_code [String] the Course identifier code, eg: MC302
  # @return [CourseMech] the initialized CourseMech
  def initialize(term, course)
    @course = course
    @term = term
    super()
    get(dac_page)
    course.update!(title: title, overview: overview)
  end

  # Find or create all the Offering models for the page that the Mech is parsing
  #
  # @return [Array<Offering>] an Offering list.
  def offerings
    (0...professors.size).map do |index|
      o = Offering.where(
        code: offering_codes[index],
        term: term,
        year: year,
        course: course,
        credits: credits,
        min_enrolled_students: min_students_required[index] || 0,
        max_enrolled_students: vacancies[index],
      ).first_or_create
      o.professors = professors[index]
      o
    end
  end

  # Find or create all the Professor models for the page that the Mech is parsing
  #
  # @return [Array<Professor>] a Professor list.
  def professors
    @professors ||= professor_names.map do |names|
      names.map do |name|
        p = Professor.find_by(name: name) || Professor.create!(name: name)
        p.update!(faculty: @course.faculty)
        p
      end
    end
  end

  # Determines, based on the course code and the term, the page that the mech should visit to get info.
  # Edgecase: F_128 and similars (The real course code is F 128, but in the URL it's F_128)
  #
  # @return [String] the course offering url in DAC's website.
  def dac_page
    "http://www.dac.unicamp.br/sistemas/horarios/grad/#{dac_url_period_param}/#{course.code.tr(' ', '_')}.htm"
  end

  # Converts a term symbol from Offring term enum to DAC's code for the term.
  #
  # @return [String] DAC's code for the analyzed term.
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

  # Discover the course full name in the html
  #
  # @return [String] The course name.
  def title
    @title ||= extract_str("//a[@name='#{course.code}']/..")
  end

  # Discover the course credits value in the html
  #
  # @return [Integer] The course credits.
  def credits
    @credits ||= extract_int("//b[.='Créditos:']/../text()")
  end

  # Discover the course description in the html
  #
  # @return [String] A course overview.
  def overview
    @overview ||= extract_str("//td[@align='LEFT'][@width='600']")
  end

  # Discover the offering year (the term is given) in the html
  #
  # (WHAT YEAR IS IT?)
  #
  # @return [Integer] The offerings year.
  def year
    @year ||= extract_int("//font[@color='#FFFFFF']/font[@size='-1']")
  end

  # Discover the offering codes in the html
  #
  # @return [Array<String>] A list with offering codes.
  def offering_codes
    @offering_codes ||= (page.search("//font[@color='#990000']/..").to_a.unshift(page.at("//b[.='Turma:']/.."))).map do |node|
      clean_str(node.text[/^Turma:(.+)$/, 1])
    end
  end

  # Discover the number of vacancies for each offering in the html
  #
  # @return [Array<Integer>] The amount of vacancy for each offering.
  def vacancies
    @vacancies ||= page.search("//b[contains(.,'vagas')]/..").map do |node|
      node.text[/\d+/].to_i
    end
  end

  # Discover the minimum number of students required for each offering in the html
  # Some courses (most of them) don't have a minimum number of students required,
  # in that case this method will return an empty array.
  #
  # @return [Array<Integer>] The minimum number of students required for each offering.
  def min_students_required
    @min_students_required ||= page.search("//b[contains(.,'mínimo')]/..").map do |node|
      node.text[/\d+/].to_i
    end
  end

  # Discover the professor name for each offering in the html
  #
  # @return [Array<Array<String>] A list with professor names.
  def professor_names
    @professor_names ||= page.search("//b[.='Docente(s):']/../text()").map do |node|
      s = clean_str(node.text)
      s.empty? ? nil : s
    end.compact.reduce([]) do |professors, professor|
      if professor.sub!(' (Responsável)', '')
        professors << [professor]
      else
        professors.last << professor
      end
      professors
    end
  end
end
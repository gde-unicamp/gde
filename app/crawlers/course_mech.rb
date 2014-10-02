require 'mechanize'

class CourseMech < Mechanize

  attr_reader :term

  def initialize(term, course_code)
    @course = course_code
    @term = term
    super()
    get(dac_page)
  end

  def course
    Course.where(
      code: @course,
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
        professor: Professor.where(name: professors[index]).first_or_create,
        min_enrolled_students: min_students_required[index] || 0,
        max_enrolled_students: vacancies[index],
      ).first_or_create
    end
  end

  def dac_page
    "http://www.dac.unicamp.br/sistemas/horarios/grad/#{dac_url_period_param}/#{@course}.htm"
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
    page.at("//a[@name='#{@course}']/..").text.mb_chars.tidy_bytes.gsub(/(\s{2,}|\u00a0)/, ' ').strip.to_s
  end

  def credits
    page.at("//b[.='Créditos:']/../text()").text[/\d+/]
  end

  def overview
    page.at("//td[@align='LEFT'][@width='600']").text.mb_chars.tidy_bytes.gsub(/(\s{2,}|\u00a0)/, ' ').strip.to_s
  end

  def year
    page.at("//font[@color='#FFFFFF']/font[@size='-1']").text[/\d+/]
  end

  def offering_codes
    (page.search("//font[@color='#990000']/..").to_a.unshift(page.at("//b[.='Turma:']/.."))).map do |node|
      node.text[/^Turma:(.+)$/, 1].mb_chars.tidy_bytes.gsub(/(\s{2,}|\u00a0)/, ' ').strip.to_s
    end
  end

  def vacancies
    @vacancies ||= page.search("//b[contains(.,'vagas')]/..").map do |node|
      node.text[/\d+/]
    end
  end

  def min_students_required
    @min_students_required ||= page.search("//b[contains(.,'mínimo')]/..").map do |node|
      node.text[/\d+/]
    end
  end

  def professors
    @professors ||= page.search("//b[.='Docente(s):']/../text()[2]").map do |node|
      node.text.mb_chars.tidy_bytes.gsub(/(\s{2,}|\u00a0)/, ' ').strip.to_s[/(.+)\s+\(Responsável\)/, 1]
    end
  end
end
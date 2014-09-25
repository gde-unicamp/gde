require 'mechanize'

class CourseMech < Mechanize

  def initialize(period, course_code)
    @course = course_code
    @period = period
    super()
  end

  def course
    get(dac_page) unless page
    Course.new(
      code: @course,
      title: title,
      credits: credits,
      overview: overview,
      term: @period,
      year: year,
      max_enrolled_students: vacancies
    )
  end

  def dac_page
    "http://www.dac.unicamp.br/sistemas/horarios/grad/#{dac_url_period_param}/#{@course}.htm"
  end

  def dac_url_period_param
    case @period
    when :first_semester
      'G1S0'
    when :second_semester
      'G2S0'
    when :summer_vacations
      'G5A0'
    end
  end

  def title
    page.at("//a[@name='#{@course}']/..").text.mb_chars.tidy_bytes.gsub(/\s{2,}/, '').strip.to_s
  end

  def credits
    page.at("//b[.='Créditos:']/../text()").text[/\d+/]
  end

  def overview
    page.at("//td[@align='LEFT'][@width='600']").text.mb_chars.tidy_bytes.gsub(/\s{2,}/, '').strip.to_s
  end

  def year
    page.at("//font[@color='#FFFFFF']/font[@size='-1']").text[/\d+/]
  end

  def vacancies
    page.at("//b[contains(.,'vagas')]/..").text[/\d+/]
  end
end
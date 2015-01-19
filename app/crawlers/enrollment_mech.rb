require 'mechanize'

#
# A Mech class that should be extended to make crawlers.
# Here you'll find some auxiliar methods to extract data from HTML
#
class EnrollmentMech < GdeMech
  def initialize(offering)
    @offering = offering
    super
    get("http://www.daconline.unicamp.br/altmatr/menupublico.do")
    get(enrollment_page)
  end

  def enrollment_page
    "http://www.daconline.unicamp.br/altmatr/conspub_matriculadospordisciplinaturma.do?org.apache.struts.taglib.html.TOKEN=#{token}&txtDisciplina=#{course_code}&txtTurma=#{@offering.code}&cboSubG=#{term}&cboSubP=#{0}&cboAno=#{@offering.year}&btnAcao=Continuar"
  end

  def term
    case @offering.term
    when 'first_semester'
      1
    when 'second_semester'
      2
    end
  end

  def token
    @token ||= page.search("//script")[1].text[/var token = "(.*)";/, 1]
  end

  def course_code
    @course_code ||= @offering.course.code
  end

  def ras
    @ras ||= page.search("//td[@width='270'][@class='corpo'][@bgcolor='white']/../td[2]").map do |node|
      node.text[/\d+/].to_i
    end
  end

  def names
    @names ||= page.search("//td[@width='270'][@class='corpo'][@bgcolor='white']").map do |node|
      clean_str(node.text)
    end
  end

  def grad_codes
    @grad_codes ||= page.search("//td[@width='270'][@class='corpo'][@bgcolor='white']/../td[4]").map do |node|
      clean_str(node.text)
    end
  end

  def tracks
    @tracks ||= page.search("//td[@width='270'][@class='corpo'][@bgcolor='white']/../td[6]").map do |node|
      clean_str(node.text)
    end
  end
end

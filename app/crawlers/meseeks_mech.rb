require 'mechanize'

class MeseeksMech

  def initialize
  end

  def scrap_em_all
    'A'.upto 'Z' do |offering_code|
      2007.upto 2014 do |year|
        Offering.terms.values[0...-1].each do |term|
          Course.find_each do |course|
            offering = Offering.where(
              code: offering_code,
              term: term,
              year: year,
              course: course,
            ).first_or_initialize
            mech = EnrollmentMech.new(offering)
            if mech.page.search("//span[contains(.,'Não existem alunos matriculados nesta disciplina/turma')]").empty? && mech.page.search("//span[contains(.,'Disciplina/turma não oferecida para nível, período e ano informados')]").empty?
              offering.save!
              mech.enrollments
            end
          end
        end
      end
    end
  end
end

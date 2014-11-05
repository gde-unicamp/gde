# == Schema Information
#
# Table name: offerings
#
#  code                  :string
#  course_id             :integer
#  created_at            :datetime         not null
#  credits               :integer
#  id                    :integer          not null, primary key
#  max_enrolled_students :integer
#  min_enrolled_students :integer          default("0")
#  term                  :integer
#  updated_at            :datetime         not null
#  website               :string
#  year                  :integer
#
# Indexes
#
#  index_offerings_on_course_id  (course_id)
#

class Offering < ActiveRecord::Base
  has_many :room_reservations
  belongs_to :course
  has_and_belongs_to_many :professors

  enum term: [ :first_semester, :second_semester, :summer_vacations ]
end

# Observations:
#
# min_enrolled_students: Some course offerings have a minimum number of students required.
# see: http://www.dac.unicamp.br/sistemas/horarios/grad/G2S0/EA722.htm
#
# HABTM professors: Some course offerings have more than one professor
# see: http://www.dac.unicamp.br/sistemas/horarios/grad/G1S0/F_012.htm
#
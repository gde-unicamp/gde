# == Schema Information
#
# Table name: offerings
#
#  course_id         :integer
#  created_at        :datetime         not null
#  credits           :integer
#  enrolled_students :integer
#  id                :integer          not null, primary key
#  professor_id      :integer
#  term              :integer
#  updated_at        :datetime         not null
#  website           :string
#  year              :integer
#
# Indexes
#
#  index_offerings_on_course_id     (course_id)
#  index_offerings_on_professor_id  (professor_id)
#

class Offering < ActiveRecord::Base
  belongs_to :professor
  belongs_to :course

  enum term: [ :first_semester, :second_semester, :summer_vacations ]
end

# == Schema Information
#
# Table name: students
#
#  created_at               :datetime
#  egress                   :boolean
#  id                       :integer          not null, primary key
#  language_choice          :string(255)
#  name                     :string(255)
#  postgraduate_program_id  :integer
#  ra                       :integer
#  track                    :string(255)
#  undergraduate_program_id :integer
#  updated_at               :datetime
#
# Indexes
#
#  index_students_on_postgraduate_program_id   (postgraduate_program_id)
#  index_students_on_undergraduate_program_id  (undergraduate_program_id)
#

class Student < ActiveRecord::Base
  belongs_to :undergraduate_program
  belongs_to :postgraduate_program

  belongs_to :track
  belongs_to :language_choice

  has_many :enrollments
  has_many :courses, through: :enrollments
end

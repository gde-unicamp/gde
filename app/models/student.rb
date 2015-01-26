# == Schema Information
#
# Table name: students
#
#  created_at               :datetime
#  egress                   :boolean
#  id                       :integer          not null, primary key
#  language_choice          :string
#  name                     :string
#  postgraduate_program_id  :integer
#  ra                       :integer
#  track_id                 :integer
#  undergraduate_program_id :integer
#  updated_at               :datetime
#
# Indexes
#
#  index_students_on_postgraduate_program_id   (postgraduate_program_id)
#  index_students_on_track_id                  (track_id)
#  index_students_on_undergraduate_program_id  (undergraduate_program_id)
#

class Student < ActiveRecord::Base
  belongs_to :undergraduate_program
  belongs_to :postgraduate_program

  belongs_to :track
  belongs_to :language_choice

  has_many :enrollments
  has_many :offerings, through: :enrollments
end

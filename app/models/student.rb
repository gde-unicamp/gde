class Student < ActiveRecord::Base
  belongs_to :undergraduate_program
  belongs_to :postgraduate_program

  belongs_to :track
  belongs_to :language_choice

  has_many :enrollments
  has_many :courses, through: :enrollments
end

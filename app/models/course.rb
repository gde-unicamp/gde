class Course < ActiveRecord::Base
  enum terms: [ :first_semester, :second_semester, :summer_vacations ]

  belongs_to :faculty
  belongs_to :professor

  has_many :room_reservations
  has_many :classrooms, through: :room_reservation

  has_many :enrollments
  has_many :students, through: :enrollments
end

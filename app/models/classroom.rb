class Classroom < ActiveRecord::Base
  belongs_to :faculty
  has_many :room_reservations
  has_many :courses, through: :room_reservation
end

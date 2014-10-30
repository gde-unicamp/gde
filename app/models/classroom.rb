# == Schema Information
#
# Table name: classrooms
#
#  created_at :datetime
#  faculty_id :integer
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime
#
# Indexes
#
#  index_classrooms_on_faculty_id  (faculty_id)
#

class Classroom < ActiveRecord::Base
  belongs_to :faculty
  has_many :room_reservations
  has_many :courses, through: :room_reservation
end

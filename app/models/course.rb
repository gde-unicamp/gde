# == Schema Information
#
# Table name: courses
#
#  code       :string
#  created_at :datetime
#  faculty_id :integer
#  id         :integer          not null, primary key
#  overview   :text
#  title      :string
#  updated_at :datetime
#
# Indexes
#
#  index_courses_on_faculty_id  (faculty_id)
#

class Course < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :professor

  has_many :room_reservations
  has_many :classrooms, through: :room_reservation

  has_many :enrollments
  has_many :students, through: :enrollments
end

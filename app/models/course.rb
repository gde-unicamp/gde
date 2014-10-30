# == Schema Information
#
# Table name: courses
#
#  code                  :string(255)
#  created_at            :datetime
#  credits               :integer
#  faculty_id            :integer
#  id                    :integer          not null, primary key
#  max_enrolled_students :integer
#  min_enrolled_students :integer
#  overview              :text
#  professor_id          :integer
#  term                  :integer
#  title                 :string(255)
#  updated_at            :datetime
#  website               :string(255)
#  year                  :integer
#
# Indexes
#
#  index_courses_on_faculty_id    (faculty_id)
#  index_courses_on_professor_id  (professor_id)
#

class Course < ActiveRecord::Base
  belongs_to :faculty
  belongs_to :professor

  has_many :room_reservations
  has_many :classrooms, through: :room_reservation

  has_many :offerings

  has_many :enrollments
  has_many :students, through: :enrollments
end

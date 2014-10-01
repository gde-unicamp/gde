# == Schema Information
#
# Table name: enrollments
#
#  course_id  :integer
#  created_at :datetime
#  id         :integer          not null, primary key
#  status     :integer
#  student_id :integer
#  updated_at :datetime
#
# Indexes
#
#  index_enrollments_on_course_id   (course_id)
#  index_enrollments_on_student_id  (student_id)
#

class Enrollment < ActiveRecord::Base
  enum status: [ :ongoing, :approved, :reproved, :abandoned ]

  belongs_to :student
  belongs_to :course
end

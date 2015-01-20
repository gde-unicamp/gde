# == Schema Information
#
# Table name: enrollments
#
#  created_at  :datetime
#  id          :integer          not null, primary key
#  offering_id :integer
#  status      :integer
#  student_id  :integer
#  updated_at  :datetime
#
# Indexes
#
#  index_enrollments_on_offering_id  (offering_id)
#  index_enrollments_on_student_id   (student_id)
#

class Enrollment < ActiveRecord::Base
  enum status: [ :ongoing, :approved, :reproved, :abandoned ]

  belongs_to :student
  belongs_to :offering
end

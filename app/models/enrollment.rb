class Enrollment < ActiveRecord::Base
  enum status: [ :ongoing, :approved, :reproved, :abandoned ]

  belongs_to :student
  belongs_to :course
end

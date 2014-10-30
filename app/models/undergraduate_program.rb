# == Schema Information
#
# Table name: undergraduate_programs
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  number     :integer
#  title      :string(255)
#  updated_at :datetime
#

class UndergraduateProgram < ActiveRecord::Base
    has_many :program_course_groups, as: :courseable_group
end

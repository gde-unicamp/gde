class UndergraduateProgram < ActiveRecord::Base
    has_many :program_course_groups, as: :courseable_group
end

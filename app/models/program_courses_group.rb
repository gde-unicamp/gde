# == Schema Information
#
# Table name: program_courses_groups
#
#  courseable_group_id   :integer
#  courseable_group_type :string
#  created_at            :datetime
#  id                    :integer          not null, primary key
#  updated_at            :datetime
#

class ProgramCoursesGroup < ActiveRecord::Base
    belongs_to :courseable_group, polymorphic: true
end

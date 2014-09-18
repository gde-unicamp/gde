class ProgramCoursesGroup < ActiveRecord::Base
    belongs_to :courseable_group, polymorphic: true
end

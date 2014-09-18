class LanguageChoice < ActiveRecord::Base
  belongs_to :undergraduate_program
  has_many :students
  has_many :program_course_groups, as: :courseable_group
end

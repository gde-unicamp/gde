# == Schema Information
#
# Table name: language_choices
#
#  code                     :string(255)
#  created_at               :datetime
#  id                       :integer          not null, primary key
#  undergraduate_program_id :integer
#  updated_at               :datetime
#
# Indexes
#
#  index_language_choices_on_undergraduate_program_id  (undergraduate_program_id)
#

class LanguageChoice < ActiveRecord::Base
  belongs_to :undergraduate_program
  has_many :students
  has_many :program_course_groups, as: :courseable_group
end

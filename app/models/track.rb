# == Schema Information
#
# Table name: tracks
#
#  code                     :string
#  created_at               :datetime
#  id                       :integer          not null, primary key
#  title                    :string
#  undergraduate_program_id :integer
#  updated_at               :datetime
#
# Indexes
#
#  index_tracks_on_undergraduate_program_id  (undergraduate_program_id)
#

class Track < ActiveRecord::Base
  belongs_to :undergraduate_program
  has_many :students
  has_many :program_course_groups, as: :courseable_group
end

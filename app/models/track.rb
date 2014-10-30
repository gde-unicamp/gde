# == Schema Information
#
# Table name: tracks
#
#  code                     :string(255)
#  created_at               :datetime
#  id                       :integer          not null, primary key
#  title                    :string(255)
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

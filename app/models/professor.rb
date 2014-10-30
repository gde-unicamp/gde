# == Schema Information
#
# Table name: professors
#
#  created_at :datetime
#  email      :string
#  faculty_id :integer
#  id         :integer          not null, primary key
#  name       :string
#  office     :string
#  updated_at :datetime
#  website    :string
#
# Indexes
#
#  index_professors_on_faculty_id  (faculty_id)
#

class Professor < ActiveRecord::Base
  belongs_to :faculty
  has_and_belongs_to_many :offerings
end

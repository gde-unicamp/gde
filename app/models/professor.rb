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

  has_many :offerings

  belongs_to :faculty
end

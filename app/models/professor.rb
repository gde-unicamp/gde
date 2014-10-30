# == Schema Information
#
# Table name: professors
#
#  created_at :datetime
#  email      :string(255)
#  faculty_id :integer
#  id         :integer          not null, primary key
#  name       :string(255)
#  office     :string(255)
#  updated_at :datetime
#  website    :string(255)
#
# Indexes
#
#  index_professors_on_faculty_id  (faculty_id)
#

class Professor < ActiveRecord::Base

  has_many :offerings

  belongs_to :faculty
end

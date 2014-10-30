# == Schema Information
#
# Table name: faculties
#
#  acronym    :string(255)
#  created_at :datetime
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime
#

class Faculty < ActiveRecord::Base
  has_many :professors
  has_many :classrooms
end

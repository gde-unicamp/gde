# == Schema Information
#
# Table name: faculties
#
#  acronym    :string
#  created_at :datetime
#  id         :integer          not null, primary key
#  name       :string
#  updated_at :datetime
#

class Faculty < ActiveRecord::Base
  has_many :professors
  has_many :classrooms
end

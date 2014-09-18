class Faculty < ActiveRecord::Base
    has_many :professors
    has_many :classrooms
end

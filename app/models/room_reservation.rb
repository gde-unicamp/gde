# == Schema Information
#
# Table name: room_reservations
#
#  classroom_id :integer
#  created_at   :datetime
#  day_of_week  :integer
#  end_time     :time
#  id           :integer          not null, primary key
#  offering_id  :integer
#  start_time   :time
#  updated_at   :datetime
#
# Indexes
#
#  index_room_reservations_on_classroom_id  (classroom_id)
#  index_room_reservations_on_offering_id   (offering_id)
#

class RoomReservation < ActiveRecord::Base
  belongs_to :classroom
  belongs_to :offering
end

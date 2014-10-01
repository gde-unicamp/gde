class CreateRoomReservations < ActiveRecord::Migration
  def change
    create_table :room_reservations do |t|
      t.integer :day_of_week
      t.time :start_time
      t.time :end_time
      t.references :classroom, index: true
      t.references :offering, index: true

      t.timestamps
    end
  end
end

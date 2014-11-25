class RoomReservationParser

  DAY_OF_WEEK_TRANSLATION = {
    'Seg' => 0,
    'Ter' => 1,
    'Qua' => 2,
    'Qui' => 3,
    'Sex' => 4
  }.freeze

  def initialize(raw, offering)
    @offering = offering
    data = raw.split(/[\s\n]/).map { |s| s.empty? ? nil : s }.compact
    @raw_day_of_week = data[0]
    @raw_reservations = data[1..-1].map do |res|
      time_and_room = res.split(/\//)
      {
        initial_time: time_and_room[0].to_time,
        room: time_and_room[1],
        duration: 1.hour
      }
    end
    i = 0
    while i < @raw_reservations.size - 1
      if @raw_reservations[i] && @raw_reservations[i][:room] == @raw_reservations[i+1][:room] &&
        (@raw_reservations[i+1][:initial_time] - @raw_reservations[i][:duration] - @raw_reservations[i][:initial_time] <= 0.01)
        @raw_reservations[i][:duration] += 1.hour
        @raw_reservations.delete_at(i+1)
        i = 0
      else
        i += 1
      end
    end
  end

  def room_reservations
    @raw_reservations.map do |res|
      RoomReservation.where(
        day_of_week: day_of_week,
        start_time: res[:initial_time],
        end_time: res[:initial_time] + res[:duration],
        classroom: Classroom.find_or_create_by(name: res[:room]),
        offering: @offering
      ).first_or_create
    end
  end

  def day_of_week
    DAY_OF_WEEK_TRANSLATION[@raw_day_of_week]
  end
end
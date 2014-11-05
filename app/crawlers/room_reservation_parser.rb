class RoomReservationParser

  DAY_OF_WEEK_TRANSLATION = {
    'Seg' => 0,
    'Ter' => 1,
    'Qua' => 2,
    'Qui' => 3,
    'Sex' => 4
  }

  def initialize(raw, offering)
    @offering = offering
    data = raw.split(/[\s\n]/).map { |s| s.empty? ? nil : s }.compact
    @raw_day_of_week = data[0]
    @raw_reservations = data[1..-1].map { |res| res.split(/\//) }
  end

  def room_reservations
    @raw_reservations.map do |res|
      RoomReservation.where(
        day_of_week: day_of_week,
        start_time: res.first.to_time,
        end_time: res.first.to_time + 1.hour,
        classroom: Classroom.find_by(name: res.last) || Classroom.create!(name: res.last),
        offering: @offering
      ).first_or_create
    end
  end

  def day_of_week
    DAY_OF_WEEK_TRANSLATION[@raw_day_of_week]
  end
end
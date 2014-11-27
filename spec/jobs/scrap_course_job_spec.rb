require 'spec_helper'

describe ScrapCourseJob do

  subject { ScrapCourseJob.new }

  it 'scraps' do
    subject.perform(Offering.terms[:second_semester], Course.find_or_create_by(code: 'MC404'))
    course = Course.find_by(code: 'MC404')
    course.wont_be_nil
    course.must_be_kind_of Course
    course.title.wont_be_nil
    course.overview.wont_be_nil
    course.offerings.wont_be_nil
    course.offerings.each do |offering|
      offering.must_be_kind_of Offering
      offering.code.wont_be_nil
      offering.term.wont_be_nil
      offering.year.wont_be_nil
      offering.course.wont_be_nil
      offering.credits.wont_be_nil
      offering.min_enrolled_students.wont_be_nil
      offering.max_enrolled_students.wont_be_nil
      offering.professors.wont_be_nil
      offering.professors.each do |professor|
        professor.wont_be_nil
        professor.must_be_kind_of Professor
        professor.name.wont_be_nil
      end
      offering.room_reservations.wont_be_nil
      offering.room_reservations do |room_reservation|
        room_reservation.wont_be_nil
        room_reservation.must_be_kind_of RoomReservation
      end
    end
  end
end

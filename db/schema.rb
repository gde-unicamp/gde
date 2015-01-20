# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141030212645) do

  create_table "classrooms", force: :cascade do |t|
    t.string   "name"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classrooms", ["faculty_id"], name: "index_classrooms_on_faculty_id"

  create_table "courses", force: :cascade do |t|
    t.string   "code"
    t.string   "title"
    t.text     "overview"
    t.integer  "faculty_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "courses", ["faculty_id"], name: "index_courses_on_faculty_id"

  create_table "enrollments", force: :cascade do |t|
    t.integer  "status"
    t.integer  "student_id"
    t.integer  "offering_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "enrollments", ["offering_id"], name: "index_enrollments_on_offering_id"
  add_index "enrollments", ["student_id"], name: "index_enrollments_on_student_id"

  create_table "faculties", force: :cascade do |t|
    t.string   "acronym"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "friendships", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "friend_id"
    t.boolean  "accepted",   default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "friendships", ["friend_id"], name: "index_friendships_on_friend_id"
  add_index "friendships", ["user_id"], name: "index_friendships_on_user_id"

  create_table "language_choices", force: :cascade do |t|
    t.string   "code"
    t.integer  "undergraduate_program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "language_choices", ["undergraduate_program_id"], name: "index_language_choices_on_undergraduate_program_id"

  create_table "offerings", force: :cascade do |t|
    t.string   "code"
    t.integer  "term"
    t.integer  "year"
    t.integer  "credits"
    t.integer  "min_enrolled_students", default: 0
    t.integer  "max_enrolled_students"
    t.string   "website"
    t.integer  "course_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "offerings", ["course_id"], name: "index_offerings_on_course_id"

  create_table "offerings_professors", id: false, force: :cascade do |t|
    t.integer "offering_id",  null: false
    t.integer "professor_id", null: false
  end

  add_index "offerings_professors", ["offering_id", "professor_id"], name: "index_offerings_professors_on_offering_id_and_professor_id"
  add_index "offerings_professors", ["professor_id", "offering_id"], name: "index_offerings_professors_on_professor_id_and_offering_id"

  create_table "postgraduate_programs", force: :cascade do |t|
    t.string   "title"
    t.integer  "degree"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "professors", force: :cascade do |t|
    t.string   "name"
    t.integer  "faculty_id"
    t.string   "email"
    t.string   "office"
    t.string   "website"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "professors", ["faculty_id"], name: "index_professors_on_faculty_id"

  create_table "program_courses_groups", force: :cascade do |t|
    t.integer  "courseable_group_id"
    t.string   "courseable_group_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "room_reservations", force: :cascade do |t|
    t.integer  "day_of_week"
    t.time     "start_time"
    t.time     "end_time"
    t.integer  "classroom_id"
    t.integer  "offering_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "room_reservations", ["classroom_id"], name: "index_room_reservations_on_classroom_id"
  add_index "room_reservations", ["offering_id"], name: "index_room_reservations_on_offering_id"

  create_table "students", force: :cascade do |t|
    t.integer  "ra"
    t.string   "name"
    t.boolean  "egress"
    t.integer  "undergraduate_program_id"
    t.integer  "track_id"
    t.string   "language_choice"
    t.integer  "postgraduate_program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "students", ["postgraduate_program_id"], name: "index_students_on_postgraduate_program_id"
  add_index "students", ["track_id"], name: "index_students_on_track_id"
  add_index "students", ["undergraduate_program_id"], name: "index_students_on_undergraduate_program_id"

  create_table "tracks", force: :cascade do |t|
    t.string   "code"
    t.string   "title"
    t.integer  "undergraduate_program_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tracks", ["undergraduate_program_id"], name: "index_tracks_on_undergraduate_program_id"

  create_table "undergraduate_programs", force: :cascade do |t|
    t.integer  "number"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "name"
    t.string   "nickname"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

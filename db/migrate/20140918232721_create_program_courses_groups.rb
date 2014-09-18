class CreateProgramCoursesGroups < ActiveRecord::Migration
  def change
    create_table :program_courses_groups do |t|
      t.integer :courseable_group_id
      t.string  :courseable_group_type

      t.timestamps
    end
  end
end

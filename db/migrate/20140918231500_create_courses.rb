class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code
      t.string :title
      t.integer :credits
      t.text :overview
      t.integer :term
      t.integer :year
      t.integer :min_enrolled_students
      t.integer :max_enrolled_students
      t.string :website
      t.references :faculty, index: true
      t.references :professor, index: true

      t.timestamps
    end
  end
end

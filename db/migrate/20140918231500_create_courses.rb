class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :code
      t.string :title
      t.text :overview
      t.references :faculty, index: true

      t.timestamps
    end
  end
end

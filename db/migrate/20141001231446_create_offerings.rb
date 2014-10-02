class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.string :code
      t.integer :term
      t.integer :year
      t.integer :credits
      t.integer :min_enrolled_students, default: 0
      t.integer :max_enrolled_students
      t.string :website
      t.references :course, index: true
      t.references :professor, index: true

      t.timestamps null: false
    end
  end
end

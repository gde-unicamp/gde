class CreateOfferings < ActiveRecord::Migration
  def change
    create_table :offerings do |t|
      t.integer :term
      t.integer :year
      t.integer :credits
      t.integer :enrolled_students
      t.string :website
      t.references :course, index: true
      t.references :professor, index: true

      t.timestamps null: false
    end
  end
end

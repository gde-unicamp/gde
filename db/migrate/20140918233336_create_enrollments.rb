class CreateEnrollments < ActiveRecord::Migration
  def change
    create_table :enrollments do |t|
      t.integer :status
      t.references :student, index: true
      t.references :offering, index: true

      t.timestamps
    end
  end
end

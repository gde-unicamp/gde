class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :ra
      t.string :name
      t.boolean :egress
      t.references :undergraduate_program, index: true
      t.references :track, index: true
      t.string :language_choice
      t.references :postgraduate_program, index: true

      t.timestamps
    end
  end
end

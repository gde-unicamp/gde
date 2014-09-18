class CreateUndergraduatePrograms < ActiveRecord::Migration
  def change
    create_table :undergraduate_programs do |t|
      t.integer :number
      t.string :title

      t.timestamps
    end
  end
end

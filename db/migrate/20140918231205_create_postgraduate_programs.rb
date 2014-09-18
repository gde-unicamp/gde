class CreatePostgraduatePrograms < ActiveRecord::Migration
  def change
    create_table :postgraduate_programs do |t|
      t.string :title
      t.integer :degree

      t.timestamps
    end
  end
end

class CreateFaculties < ActiveRecord::Migration
  def change
    create_table :faculties do |t|
      t.string :acronym
      t.string :name

      t.timestamps
    end
  end
end

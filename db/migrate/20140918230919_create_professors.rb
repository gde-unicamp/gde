class CreateProfessors < ActiveRecord::Migration
  def change
    create_table :professors do |t|
      t.string :name
      t.references :faculty, index: true
      t.string :email
      t.string :office
      t.string :website

      t.timestamps
    end
  end
end

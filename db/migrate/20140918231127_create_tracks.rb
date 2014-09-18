class CreateTracks < ActiveRecord::Migration
  def change
    create_table :tracks do |t|
      t.string :code
      t.string :title
      t.references :undergraduate_program, index: true

      t.timestamps
    end
  end
end

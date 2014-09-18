class CreateLanguageChoices < ActiveRecord::Migration
  def change
    create_table :language_choices do |t|
      t.string :code
      t.references :undergraduate_program, index: true

      t.timestamps
    end
  end
end

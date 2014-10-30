class CreateJoinTableOfferingProfessor < ActiveRecord::Migration
  def change
    create_join_table :offerings, :professors do |t|
      t.index [:offering_id, :professor_id]
      t.index [:professor_id, :offering_id]
    end
  end
end

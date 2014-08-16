class CreateFriendships < ActiveRecord::Migration
  def change
    create_table :friendships do |t|
      t.references :user, index: true
      t.references :friend, index: true
      t.boolean :accepted, default: false

      t.timestamps
    end
  end
end

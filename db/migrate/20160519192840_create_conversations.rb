class CreateConversations < ActiveRecord::Migration
  def change
    create_table :conversations do |t|
      t.integer :user_id
      t.integer :coach_id
      t.boolean :active

      t.timestamps null: false
    end
  end
end

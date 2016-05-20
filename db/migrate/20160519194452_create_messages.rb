class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.integer :user_id
      t.integer :conversation_id
      t.boolean :read

      t.timestamps null: false
    end
  end
end

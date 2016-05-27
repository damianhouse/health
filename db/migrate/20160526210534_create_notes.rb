class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :user_id
      t.integer :coach_id
      t.string :note_1
      t.string :note_2
      t.string :note_3
      t.string :note_4
      t.string :note_5
      t.string :note_6
      t.string :note_7
      t.string :note_8
      t.string :note_9
      t.string :note_10

      t.timestamps null: false
    end
  end
end

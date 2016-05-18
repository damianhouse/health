class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password
      t.string :role
      t.integer :coach_id
      t.integer :coach_1
      t.integer :coach_2
      t.integer :coach_3
      t.integer :coach_4

      t.timestamps null: false
    end
  end
end

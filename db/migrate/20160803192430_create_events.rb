class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.binary :raw_body

      t.timestamps null: false
    end
  end
end

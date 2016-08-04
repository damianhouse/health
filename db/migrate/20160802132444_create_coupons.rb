class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string :code
      t.integer :discount_percent
      t.integer :discount_amount
      t.timestamp :expires_at
      t.string :description

      t.timestamps null: false
    end
  end
end

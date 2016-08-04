class AddDurationInMonthsToCoupons < ActiveRecord::Migration
  def change
    add_column :coupons, :duration_in_months, :integer
  end
end

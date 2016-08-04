class AddExpDateToUser < ActiveRecord::Migration
  def change
    add_column :users, :exp_date, :datetime
  end
end

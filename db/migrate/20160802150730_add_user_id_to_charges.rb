class AddUserIdToCharges < ActiveRecord::Migration
  def change
    add_column :charges, :user_id, :integer
  end
end

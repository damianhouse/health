class AddApprovedToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :approved, :boolean, default: false
  end
end

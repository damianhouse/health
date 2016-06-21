class ChangeColumnNameAgain < ActiveRecord::Migration
  def change
    rename_column :coaches, :name, :first
    add_column :coaches, :last, :string
    rename_column :users, :name, :first
    add_column :users, :last, :string
  end
end

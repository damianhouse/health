class AddColumnToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :philosophy, :text
  end
end

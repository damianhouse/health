class AddGreetingToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :greeting, :text
  end
end

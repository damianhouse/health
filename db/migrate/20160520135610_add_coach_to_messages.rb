class AddCoachToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :coach_id, :integer
  end
end

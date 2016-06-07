class RemoveColumnsFromCoaches < ActiveRecord::Migration
  def change
    remove_column :coaches, :avatar_file_name, :string
    remove_column :coaches, :avatar_content_type, :string
    remove_column :coaches, :avatar_file_size, :integer
    remove_column :coaches, :avatar_updated_at, :datetime
  end
end

class AddAvatarToCoaches < ActiveRecord::Migration
  def change
    add_column :coaches, :avatar_url, :string
    add_column :coaches, :phone, :string
    add_column :coaches, :zip, :string
  end
end

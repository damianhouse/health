class AddAvatarStuffz < ActiveRecord::Migration
  def change
    add_column :users, :avatar_url, :string
    add_column :users, :phone, :string
    add_column :users, :zip, :string
  end
end

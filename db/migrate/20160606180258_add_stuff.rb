class AddStuff < ActiveRecord::Migration
  def change
    add_attachment :coaches, :avatar


  end
end

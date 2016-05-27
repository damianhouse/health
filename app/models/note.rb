class Note < ActiveRecord::Base
  belongs_to :coach
  belongs_to :user


end

class Message < ActiveRecord::Base
  belongs_to :conversation
  belongs_to :user
  belongs_to :coach
  
end

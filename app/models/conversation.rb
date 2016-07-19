class Conversation < ActiveRecord::Base
  belongs_to :user
  belongs_to :coach
  has_many :messages, dependent: :destroy

end

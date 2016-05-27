class Coach < ActiveRecord::Base
  has_many :users
  has_many :messages
  has_many :notes
  has_many :conversations

  has_secure_password

end

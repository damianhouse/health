class Coach < ActiveRecord::Base
  has_many :users
  has_many :conversations
  has_secure_password

end

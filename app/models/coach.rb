class Coach < ActiveRecord::Base
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  has_many :users
  has_many :messages
  has_many :notes
  has_many :conversations
  has_secure_password

  def find_user_1
    User.where(coach_1: self.id)
  end

  def find_user_2
    User.where(coach_2: self.id)
  end

  def find_user_3
    User.where(coach_3: self.id)
  end

  def find_user_4
    User.where(coach_4: self.id)
  end

  def find_user_5
    User.where(coach_5: self.id)
  end

end

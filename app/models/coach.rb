class Coach < ActiveRecord::Base
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, length: { minimum: 8 }, allow_nil: true
  validates :greeting, presence: true
  validates :philosophy, presence: true
  validates :first, presence: true
  validates :last, presence: true
  validate :uniqueness_of_email_across_models
  has_many :users
  has_many :messages
  has_many :notes, dependent: :destroy
  has_many :conversations, dependent: :destroy
  has_secure_password
  before_save { |user| user.email = user.email.downcase }

  def secondary_coach(coach)
    User.all.select { |u| u.coach_1 == coach.id || u.coach_2 == coach.id || u.coach_3 == coach.id || u.coach_4 == coach.id }
  end

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

  def uniqueness_of_email_across_models
    self.errors.add(:email, 'is already taken') if User.where('lower(email) = ?', self.email.downcase).exists?
  end

end

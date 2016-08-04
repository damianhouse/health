class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-zA-Z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, length: { minimum: 8 }, allow_nil: true
  validate :uniqueness_of_email_across_models
  belongs_to :coach
  has_many :conversations, dependent: :destroy
  has_many :messages
  has_many :notes, dependent: :destroy
  has_secure_password
  before_save { |user| user.email = user.email.downcase }


  def add_time(plan, interval_count)
    unless plan.nil?
      if exp_date.nil?
        case plan
        when "week"
          self.exp_date = (DateTime.now + 1.week)
          self.save!
        when "month"
          self.exp_date = (DateTime.now + (1.month * interval_count))
          self.save!
        when "year"
          self.exp_date = (DateTime.now + 1.year)
          self.save!
        else
          return
        end
      else
        case plan
        when "week"
          self.exp_date += 1.week
          self.save!
        when "month"
          self.exp_date += (1.month * interval_count)
          self.save!
        when "year"
          self.exp_date += 6.month
          self.save!
        else
          return
        end
      end
    end
  end

  def uniqueness_of_email_across_models
    self.errors.add(:email, 'is already taken') if Coach.where('lower(email) = ?', self.email.downcase).exists?
  end

end

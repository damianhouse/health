class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A([^@\s]+)@((?:[-a-zA-Z0-9]+\.)+[a-z]{2,})\z/i, on: :create }
  validates :password, length: { minimum: 8 }, allow_nil: true
  validate :uniqueness_of_email_across_models
  validates :first, presence: true
  validates :last, presence: true
  belongs_to :coach
  has_many :conversations, dependent: :destroy
  has_many :messages
  has_many :notes, dependent: :destroy
  has_secure_password
  before_save { |user| user.email = user.email.downcase }
  attr_accessor :first_step, :second_step, :current_step


  def user_expired?
    if self.exp_date
      self.exp_date > DateTime.now
    end
  end

  def find_coach_1
    if self.coach_1 != nil
      Coach.find(self.coach_1)
    else
      return nil
    end
  end

  def find_coach_2
    if self.coach_2 != nil
      Coach.find(self.coach_2)
    else
      return nil
    end
  end

  def find_coach_3
    if self.coach_3 != nil
      Coach.find(self.coach_3)
    else
      return nil
    end
  end

  def find_coach_4
    if self.coach_4 != nil
      Coach.find(self.coach_4)
    else
      return nil
    end
  end

  def add_time(plan, interval_count)
    interval_count.to_i
    unless plan.nil?
      if exp_date.nil?
        case plan
        when "week"
          self.exp_date = (DateTime.now + 1.week)
          self.save!
        when "month"
          self.exp_date = (DateTime.now + (interval_count.month))
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
          self.exp_date += (interval_count.month)
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



  def steps
    %w[first_step second_step]
  end

  def current_step
    @current_step ||= steps.first
  end

  def first_step?
    current_step == "first_step"
  end

  def second_step?
    current_step == "second_step"
  end

  def next_step
    self.current_step = steps[steps.index(current_step)+1]
  end

  def previous_step
    self.current_step = steps[steps.index(current_step)-1]
  end

  def last_step?
    self.current_step == steps.last
  end
  def all_valid?
    steps.all? do |step|
      self.current_step = step
      valid?
    end
  end

  def uniqueness_of_email_across_models
    self.errors.add(:email, 'is already taken') if Coach.where('lower(email) = ?', self.email.downcase).exists?
  end

end

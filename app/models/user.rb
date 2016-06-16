class User < ActiveRecord::Base
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { in: 8..20 }
  belongs_to :coach
  has_many :conversations
  has_many :messages
  has_many :notes
  has_secure_password

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

end

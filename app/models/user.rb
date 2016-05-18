class User < ActiveRecord::Base
  belongs_to :coach
  has_secure_password



  def find_coach_1
    Coach.find(self.coach_1)
  end

  def find_coach_2
    Coach.find(self.coach_2)
  end

  def find_coach_3
    Coach.find(self.coach_3)
  end

  def find_coach_4
    Coach.find(self.coach_4)
  end

end

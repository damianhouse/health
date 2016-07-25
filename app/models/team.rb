class Team < ActiveRecord::Base


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

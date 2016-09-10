class TeamsController < ApplicationController
before_action :paid?, only: [:index]
before_action :logged_in?

    def index
       if session[:coach_id] != nil
         @coach = Coach.find(session[:coach_id])
         @secondary_coach = User.all.where("coach_1 = ? OR coach_2 = ? OR coach_3 = ? OR coach_4 = ?", @coach.id, @coach.id, @coach.id, @coach.id)
       elsif session[:user_id] != nil
        @user = User.find(session[:user_id])
        @secondary_coaches = []
        @secondary_coaches << Coach.find(@user.coach_1)
        @secondary_coaches << Coach.find(@user.coach_2)
       end
      @conversation = Conversation.new
      @note = Note.new
      @daily_inspo = Inspiration.new.random_inspo
    end

  end

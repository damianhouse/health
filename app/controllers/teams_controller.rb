class TeamsController < ApplicationController


    def index

       if session[:coach_id] != nil
         @coach = Coach.find(session[:coach_id])
      elsif session[:user_id] != nil
        @user = User.find(session[:user_id])
       end

    end


  end

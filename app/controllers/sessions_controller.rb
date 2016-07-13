class SessionsController < ApplicationController


    def login
      if request.post?
        coach = Coach.find_by('lower(email) = ?', params[:email].downcase)
        user = User.find_by('lower(email) = ?', params[:email].downcase)

        if coach && coach.authenticate(params[:password])
          session[:coach_id] = coach.id
          redirect_to teams_index_path, notice: "Login successful."

        elsif user && user.authenticate(params[:password]) && user.paid
          session[:user_id] = user.id
          redirect_to teams_index_path, notice: "Login successful."
        elsif user && user.authenticate(params[:password]) && user.paid == nil
          session[:user_id] = user.id
          redirect_to menu_welcome_path
        else
          flash.now[:notice] = "Either your password or email are invalid."
        end
      elsif session[:user_id] != nil
        redirect_to teams_index_path
      elsif session[:coach_id] != nil
        redirect_to teams_index_path
      end


    end

    def logout
      session[:user_id] = nil
      session[:coach_id] = nil

      redirect_to sessions_login_path, alert: "You've beens successfully logged out. Check back soon!"
    end

  end

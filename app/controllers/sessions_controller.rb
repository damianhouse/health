class SessionsController < ApplicationController


    def login
      if request.post?
        coach = Coach.find_by(email: params[:email])
          user = User.find_by(email: params[:email])

        if coach && coach.authenticate(params[:password])
          session[:coach_id] = coach.id
          redirect_to coaches_path, notice: "Login successful."

        elsif user && user.authenticate(params[:password])
          session[:user_id] = user.id
          redirect_to users_path, notice: "Login successful."

        else
          flash[:notice] = "You stink at remembering your password.  Try 'monkey'."

        end
      end
    end

    def logout
      session[:user_id] = nil
      session[:coach_id] = nil

      redirect_to authenticate_login_path, notice: "See you real soon!"
    end

  end

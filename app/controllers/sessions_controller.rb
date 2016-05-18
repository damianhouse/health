class SessionsController < ApplicationController


    def login
      if request.post?
        coach = Coach.find_by(email: params[:email])

        if coach && coach.authenticate(params[:password])
          session[:coach_id] = coach.id
          redirect_to coaches_path, notice: "Login successful."
        else
          flash[:notice] = "You stink at remembering your password.  Try 'monkey'."
        end
      end
    end

    def logout
      session[:user_id] = nil
      redirect_to authenticate_login_path, notice: "See you real soon!"
    end

  end

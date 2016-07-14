class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def logged_in?
    @current_user = User.find_by(id: session[:user_id]) || Coach.find_by(id: session[:coach_id])
    # render json: "You may only edit your own shtuff." unless session[:user_id] == @current_user.id
  end

  def paid?
    @current_user = User.find_by(id: session[:user_id]) || Coach.find_by(id: session[:coach_id])
    unless !@current_user.respond_to?(:paid) ||  @current_user.paid == true
      redirect_to :back, notice: "Please pay before accessing this page."
    end
  end

  # def generate_random
  #   coach_id_array = []
  #   r = rand(1..5)
  #   3.times do
  #     unless coach_id_array.include?(r)
  #       coach_id_array << r
  #     end
  #   end
  # end
end

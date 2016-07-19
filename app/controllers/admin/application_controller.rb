# All Administrate controllers inherit from this `Admin::ApplicationController`,
# making it the ideal place to put authentication logic or other
# before_filters.
#
# If you want to add pagination or other controller-level concerns,
# you're free to overwrite the RESTful controller actions.
module Admin
  class ApplicationController < Administrate::ApplicationController
    # before_action :authenticate_user!
    before_filter :authenticate_admin

    def authenticate_admin
      current_user = User.find(session[:user_id])
      unless current_user.admin?
        redirect_to '/', alert: 'Not authorized.'
      end
    end
  end
end

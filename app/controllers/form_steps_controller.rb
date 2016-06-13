class FormStepsController < ApplicationController
  include Wicked::Wizard
  steps :contact

  def show
    @user = User.find_by(id: session[:user_id])
    render_wizard
  end

  def update
    @user = User.find_by(id: session[:user_id])
    @user.update_attributes(params[:user].permit(:role_ids))
    render_wizard @user
  end

  private
  def redirect_to_finish_wizard(options=nil)
    redirect_to notifications_notify_path
  end
end

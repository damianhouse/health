class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :validate_user_or_admin, only: [:edit, :update, :destroy]
  before_action :validate_user_or_coach, only: [:show]
  before_action :set_s3_direct_post, only: [:new, :edit, :create, :update]
  before_action :logged_in?, only: [:edit]
  # GET /users
  # GET /users.json
  def index
    # @users = User.all

  end

  # GET /users/1
  # GET /users/1.json
  def show

  end

  # GET /users/new
  def new
    session[:user_params] ||= {}
    @user = User.new(session[:user_params])
    @user.current_step = session[:user_step]
    @coaches = Coach.all.where(approved: true)
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    session[:user_params].deep_merge!(params[:user]) if params[:user]
    @user = User.new(session[:user_params])
    @user.current_step = session[:user_step]
    @coaches = Coach.all.where(approved: true)
    if @user.valid?
      if params[:previous_button]
        @user.previous_step
      elsif @user.last_step?
        @user.save if @user.all_coaches_choosen?
        session[:user_step] = nil
        session[:user_params] = nil
        flash[:notice] = "User successfully created!"
        session[:user_id] = @user.id
        redirect_to charges_new_path
        return
        # ReportMailer.send_confirmation(@user).deliver_now
      else
        @user.next_step
      end
      session[:user_step] = @user.current_step
    end
    if @user.new_record?
      render 'new'
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        session[:avatar] = @user.avatar_url
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def write_email
  end

  def send_email
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def validate_user_or_admin
      if (@user.id == session[:user_id]) || (User.find(session[:user_id]).admin if session[:user_id])
        edit_coach_path
      else
        render json: "You do not have permission to access this page."
      end
    end

    def validate_user_or_coach
      if (@user.id == session[:user_id]) || session[:coach_id]
        edit_coach_path
      else
        render json: "You do not have permission to access this page."
      end
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first, :last, :email, :password, :password_digest, :role, :coach_id, :coach_1, :coach_2, :coach_3, :coach_4, :avatar_url, :phone, :zip, :admin, :stripe_id, :exp_date, :paid, :role, :current_step, :user, :previous_button)
    end
end

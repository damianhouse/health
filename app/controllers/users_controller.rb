class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, only: [:index]
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
    if session[:user_id] != @user.id && !session[:coach_id]
      render json: "You do not have permission to access this page"
    end
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    if @user.id == @current_user.id
      edit_user_path
    else
      render json: "You do not have permission to access this page"
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        ReportMailer.send_confirmation(@user).deliver_now
        session[:user_id] = @user.id
        format.html { redirect_to form_steps_path }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
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

    def validate_user
      if session[:user_id] == nil
        redirect_to sessions_login_path
      else
        @user = User.find(session[:user_id])
      end
    end

    def set_s3_direct_post
      @s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:first, :last, :email, :password, :password_digest, :role, :coach_id, :coach_1, :coach_2, :coach_3, :coach_4, :avatar_url, :phone, :zip, :admin)
    end
end

class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:show, :index]
  before_action :verify_user_or_coach_or_admin?, only: [:show]
  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = @current_user.conversations
  end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    @anchor = "my_anchor"
    if @current_user && (@current_user.id == @conversation.coach_id || @current_user.id == @conversation.user_id)
      @message = Message.new

      if session[:user_id]
        @profile = @conversation.coach
        @perspective = "user"
      elsif session[:coach_id]
        @profile = @conversation.user
        @perspective = "coach"
      end

      @name = "#{@profile.first} #{@profile.last}"

    #mark conversations read after user/coach views
      @conversation.messages.each do |msg|
        if msg.read.nil?
          if session[:coach_id]
            (msg[:read] = true) && msg.save! if msg.user != nil
          elsif session[:user_id]
            (msg[:read] = true) && msg.save! if msg.coach != nil
          end
        end
      end
    else
      render json: "You do not have permission to access that page."
    end

  end

  # GET /conversations/new
  def new
    @conversation = Conversation.new
  end

  # GET /conversations/1/edit
  def edit
  end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)

    respond_to do |format|
      if @conversation.save
        format.html { redirect_to @conversation, notice: 'Conversation was successfully created.' }
        format.json { render :show, status: :created, location: @conversation }
      else
        format.html { render :new }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /conversations/1
  # PATCH/PUT /conversations/1.json
  def update
    respond_to do |format|
      if @conversation.update(conversation_params)
        format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
        format.json { render :show, status: :ok, location: @conversation }
      else
        format.html { render :edit }
        format.json { render json: @conversation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /conversations/1
  # DELETE /conversations/1.json
  def destroy
    @conversation.destroy
    respond_to do |format|
      format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    def verify_user_or_coach_or_admin?
      if session[:admin]
        conversation_path
      elsif session[:coach_id]
        conversation_path if (@conversation.coach == Coach.find(session[:coach_id]))
      elsif session[:user_id]
        conversation_path if (@conversation.user == User.find(session[:user_id]))
      else
        render json: "You do not have permission to access this page."
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit(:user_id, :coach_id, :active)
    end
end

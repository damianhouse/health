class ConversationsController < ApplicationController
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  before_action :logged_in?, only: [:show]
  # GET /conversations
  # GET /conversations.json
  def index
    @conversations = Conversation.all
  end



  # GET /conversations/1
  # GET /conversations/1.json
  def show
    if @current_user.id == @conversation.coach_id || @current_user.id == @conversation.user_id
      @message = Message.new

      if session[:user_id] != nil
        @profile = @conversation.coach
        @perspective = "user"
      else
        @profile = @conversation.user
        @perspective = "coach"
      end

      @name = "#{@profile.first} #{@profile.last}"

    #mark conversations read after user/coach views
      @conversation.messages.each do |msg|
        if session[:coach_id] != nil
            if msg.user_id != nil
              msg.read = true
              msg.save!
            end
        elsif session[:user_id] != nil
          if msg.coach_id != nil
            msg.read = true
            msg.save!
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit(:user_id, :coach_id, :active)
    end
end

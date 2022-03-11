class ItemtestsController < ApplicationController
    include Devise::Controllers::Helpers 
  before_action :set_itemtest, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :redirect_if_not_author_or_admin, only: [:edit, :update, :destroy] 
  #before_action :count_visits

  # GET /itemtests or /itemtests.json
  def index
    @itemtests = Itemtest.all.includes(:user).decorate

  end
  def search
    @itemtests = Itemtest.where("name LIKE ?", "%" +params[:q]+ "%")
  end

  # GET /itemtests/1 or /itemtests/1.json
  def show
  end

  # GET /itemtests/new
  def new
    @itemtest = Itemtest.new
  end

  # GET /itemtests/1/edit
  def edit
  end

  # POST /itemtests or /itemtests.json
  def create
    @itemtest = Itemtest.new(itemtest_params)
    @itemtest.user_id = current_user.id
    if !(cookies[:user].blank?)
      redirect_to new_itemtest_path, flash: {notice: "Please wait for 5 minutes and try again, quota exceeded"}
    else
      if cookies[:cookiebar].to_s.include?('CookieAllowed')
  cookies[:user] = {value: current_user.id, expires: 5.minutes.from_now} 
      end          
    respond_to do |format|
      if @itemtest.save
        format.html { redirect_to itemtest_url(@itemtest), notice: "Itemtest was successfully created." }
        format.json { render :show, status: :created, location: @itemtest }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @itemtest.errors, status: :unprocessable_entity }
      end
    end
  end
end


  # PATCH/PUT /itemtests/1 or /itemtests/1.json
  def update
    respond_to do |format|
      if @itemtest.update(itemtest_params)
        format.html { redirect_to itemtest_url(@itemtest), notice: "Itemtest was successfully updated." }
        format.json { render :show, status: :ok, location: @itemtest }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @itemtest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /itemtests/1 or /itemtests/1.json
  def destroy
    @itemtest.destroy

    respond_to do |format|
      format.html { redirect_to itemtests_url, notice: "Itemtest was successfully destroyed." }
      format.json { head :no_content }
    end
  end
  
  private
   
  def redirect_if_not_author_or_admin
    redirect_to itemtests_path if !@itemtest || @itemtest.user_id != current_user.id && !current_user.admin?
  end


    # Use callbacks to share common setup or constraints between actions.
    def set_itemtest
      @itemtest = Itemtest.find(params[:id]).decorate
    end

    # Only allow a list of trusted parameters through.
    def itemtest_params
      params.require(:itemtest).permit(:name, :description, :user_id, :image)
    end
end

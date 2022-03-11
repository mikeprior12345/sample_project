class UsersController < ApplicationController
  include Devise::Controllers::Helpers 
  before_action :authenticate_user!
  before_action :authenticate_admin!, only: [:index, :toggleadmin, :destroy]
  
  def index
    @users = User.all
  end

  def toggleadmin
    @user ||= User.find params[:id]
    @user.toggle! :admin
    redirect_to users_url
  end
  def destroy
    @user ||= User.find params[:id]
    @user.destroy
    respond_to do |format|
    format.html { redirect_to users_url, notice: "User was successfully destroyed." }
  end
end

        def authenticate_admin!
        unless current_user.admin?
           redirect_to root_path, notice: "Access Restricted"
        end
  end
end

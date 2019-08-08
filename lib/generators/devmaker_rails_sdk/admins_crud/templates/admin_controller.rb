class AdminController < ApplicationController
  before_action :authenticate_admin!, except: :redirect


  def current_page
    params[:page] || 1
  end

  def redirect
    render :layout => "blank"
  end

  private

  def authenticate_admin!
    redirect_to(new_user_session_path) unless current_admin
  end

  def current_admin
    if current_user&.admin?
      current_user.owner
    else
      # sign_out(current_user) if current_user
      redirect_to(redirect_path) if current_user
    end
  end

  helper_method :current_admin
end

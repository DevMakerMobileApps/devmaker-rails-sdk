class USERNAMEController < ApplicationController
  before_action :authenticate_DOWNUSERNAME!

  private

  def authenticate_DOWNUSERNAME!
    head(:forbidden) and return unless current_DOWNUSERNAME
  end

  def current_DOWNUSERNAME
    current_user.owner if current_user&.DOWNUSERNAME?
  end

  helper_method :current_DOWNUSERNAME
end

class HomeController < ApplicationController
  skip_before_action :authenticate_user!
  before_action :redirect_if_signed_in

  def index; end

  protected

    def redirect_if_signed_in
      redirect_to current_troop_path if user_signed_in?
    end
end

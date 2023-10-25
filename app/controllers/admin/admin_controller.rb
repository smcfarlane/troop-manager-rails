class Admin::AdminController < ApplicationController
  before_action :check_admin

  def check_admin
    redirect_to root_path unless current_user&.admin?
  end
end

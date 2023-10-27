class Admin::AdminController < ActionController::Base
  include Pagy::Backend

  before_action :authenticate_user!
  before_action :check_admin

  layout 'admin'

  def check_admin
    redirect_to root_path unless current_user&.admin?
  end
end

class Admin::MembershipsController < Admin::AdminController
  before_action :load_source
  before_action :load_membership, only: [:show, :destroy]

  def index
    @memberships = @source.memberships.all_details.order(:current, :role)
  end

  def show; end

  def new
    @membership = @source.memberships.new
  end

  def create
  end

  def destroy
    @membership.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@membership) }
      format.html { redirect_to admin_user_path(@user), notice: 'Membership was successfully removed.', status: :see_other }
    end
  end

  protected

    def load_source
      @source =
        if params[:troop_id].present?
          load_troop
        elsif params[:user_id].present?
          load_user
        else
          raise ActionController::RoutingError.new('Not Found')
        end
      raise ActionController::RoutingError.new('Not Found') unless @source
    end

    def load_troop
      @troop = Troop.find_by_id(params[:troop_id])
    end

    def load_user
      @user = User.find_by_id(params[:user_id])
    end

    def load_membership
      @membership = @user.memberships.find(params[:id])
    end

    def membership_params
      params.require(:membership).permit(:role)
    end
end

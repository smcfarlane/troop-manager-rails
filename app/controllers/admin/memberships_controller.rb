class Admin::MembershipsController < Admin::AdminController
  before_action :load_source, except: [:show, :destroy]

  def index
    @memberships = @source.memberships.all_details.order(:current, :role)
  end

  def show
    @membership = Membership.includes(:user, :troop).find(params[:id])
  end

  def new
    @membership = @source.memberships.new
  end

  def create
    @membership = @source.memberships.new(membership_params)
    respond_to do |format|
      if @membership.save
        format.turbo_stream
        format.html { redirect_to admin_user_path(@user), notice: 'Membership was successfully created.', status: :see_other }
      else
        format.turbo_stream
        format.html { render :new }
      end
    end
  end

  def destroy
    @membership = Membership.find(params[:id])
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

    def membership_params
      params.require(:membership).permit(:role, :troop_id, :user_id, :current)
    end
end

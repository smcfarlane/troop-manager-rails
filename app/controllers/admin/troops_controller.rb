class Admin::TroopsController < Admin::AdminController
  before_action :load_troop, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @troops = pagy(Troop.order(created_at: :desc), items: 10)
  end

  def show; end

  def new
    @troop = Troop.new
    @troop.build_address
  end

  def create
    @troop = Troop.new(troop_params)
    if @troop.save
      redirect_to admin_troop_path(@troop), notice: "Troop created", status: :see_other
    else
      render :new
    end
  end

  def edit; end

  def update
    if @troop.update(troop_params)
      redirect_to admin_troop_path(@troop), notice: "Troop created"
    else
      render :new
    end
  end

  def destroy
    @troop.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@troop) }
      format.html { redirect_to admin_troops_path, notice: "Troop deleted", status: :see_other }
    end
  end

  protected

    def load_troop
      @troop = Troop.find(params[:id])
    end

    def troop_params
      params.require(:troop).permit(:name, :number, :image, :state, address_attributes: [:id, :address_text])
    end
end

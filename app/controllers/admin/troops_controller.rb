class Admin::TroopsController < Admin::AdminController
  before_action :load_troop, only: [:show, :edit, :update, :destroy]

  def index
    @troops = Troop.order(created_at: :desc)
  end

  def show; end

  def new
    @troop = Troop.new
  end

  def create
    @troop = Troop.new(troop_params)
    if @troop.save
      redirect_to admin_troop_path(@troop), notice: "Troop created"
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
    redirect_to admin_troops_path, notice: "Troop deleted"
  end

  protected

    def load_troop
      @troop = Troop.find(params[:id])
    end

    def troop_params
      params.require(:troop).permit(:name, :number, :image, :state, addresses_attributes: [:id, :address_text])
    end
end

class Admin::UsersController < Admin::AdminController
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.with_current_troop.order(created_at: :desc)
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "User created", status: :see_other
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "User created", status: :see_other
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@user) }
      format.html { redirect_to admin_users_path, notice: "User deleted", status: :see_other }
    end
  end

  protected

    def load_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user)
        .permit(:email, :password, :password_confirmation, :name, :admin)
    end
end

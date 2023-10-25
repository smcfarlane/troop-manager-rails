class Admin::UserController < Admin::AdminController
  before_action :load_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.order(created_at: :desc)
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_user_path(@user), notice: "User created"
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "User created"
    else
      render :new
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice: "User deleted"
  end

  protected

    def load_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user)
        .permit(:email, :password, :password_confirmation, :name)
    end
end

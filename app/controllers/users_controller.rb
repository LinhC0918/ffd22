class UsersController < ApplicationController
  before_action :load_user, only: %i(show edit update)
  before_action :logged_in_user, only: %i(index edit update)
  before_action :correct_user, only: %i(edit update)

  def index
    @users = User.paginate page: params[:page], per_page: Settings.per_page
  end

  def new
    @user = User.new
  end

  def show; end

  def create
    @user = User.new user_params
    if @user.save
      @user.send_activation_email
      flash[:info] = t ".check_email"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = t ".update.profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  private

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t ".load_user.user_not_found"
    redirect_to :root
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :phone
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t ".logged_in_user.please_log_in"
    redirect_to login_path
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end
end

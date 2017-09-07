class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]
  before_action :require_same_user, only: [:edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit!)

    if @user.save
      flash["notice"] = "New user has been created successfully."
      session[:user_id] = @user.id
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @user.update(params.require(:user).permit!)
      flash['notice'] = "Updated successfully!"
      redirect_to posts_path
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find_by slug: params[:id]
  end

  def require_same_user
    if session[:user_id] != params[:id]
      flash["error"] = "Wrong user."
      redirect_to root_path
    end
  end
end
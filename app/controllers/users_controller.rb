require 'pry'

class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def new
    @user = User.new
  end

  def create
    @user = User.new(params.require(:user).permit!)

    if @user.save
      flash["notice"] = "New user has been created successfully."
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @tag = params[:tag]
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
    @user = User.find(params[:id])
  end
end
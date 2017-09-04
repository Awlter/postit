require 'pry'

class UsersController < ApplicationController
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
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(params.require(:user).permit!)
      flash['notice'] = "Updated successfully!"
      redirect_to posts_path
    else
      render :edit
    end
  end
end
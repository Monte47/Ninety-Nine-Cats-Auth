class UsersController < ApplicationController
  def new
    if current_user
      redirect_to cats_url
    else
      render :new
    end
  end

  def create
    @user = User.new(user_params)

    if @user.valid?
      @user.save!
      login!(@user)
      redirect_to user_url(@user)
    else
      render :new
    end
  end

  def show
    @user = find_user
  end

  private

  def find_user
    User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:user_name, :password)
  end
end

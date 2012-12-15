class UsersController < ApplicationController
  def new
    @user = User.new
    @user.build_owned_company
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      session[:user_id] = @user.id
      redirect_to sites_url, notice: "Thank you for signing up!"
    else
      render "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      redirect_to sites_url, notice: "Updated profile."
    else
      render "new"
    end
  end
end

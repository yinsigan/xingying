class UsersController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :authenticate_user!, only: [:email_uniqueness_validater]
  def show
  end

  # email唯一性验证
  def email_uniqueness_validater
    if params[:user].present? && params[:user][:email] && !User.pluck(:email).include?(params[:user][:email])
      render :nothing => true, :status => 200
    else
      render text: false
    end
  end
end
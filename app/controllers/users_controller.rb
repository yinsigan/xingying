class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:show]

  def show
  end

  def check_email
    respond_to do |format|
      format.json do
        render json: {valid: !User.where('email = ?',  params[:user][:email]).exists?}
      end
    end
  end
end
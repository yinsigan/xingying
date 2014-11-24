class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_many :public_accounts
  has_many :tickets

  mount_uploader :avatar, UserAvatarUploader

  enum role: [:user, :admin, :super_admin]

  def first_admin?
    Settings.admin_emails && Settings.admin_emails.include?(email)
  end

  def timeout_in
    30.minutes
  end
end
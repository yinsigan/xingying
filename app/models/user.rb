class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :timeoutable

  has_many :public_accounts
  has_many :tickets
  has_many :comments

  mount_uploader :avatar, UserAvatarUploader

  enum role: [:user, :admin, :super_admin]

  def timeout_in
    30.minutes
  end
end
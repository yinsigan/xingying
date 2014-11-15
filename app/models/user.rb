class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :timeoutable
  has_many :public_accounts

  def admin?
    Settings.admin_emails && Settings.admin_emails.include?(email)
  end

  def timeout_in
    30.minutes
  end
end

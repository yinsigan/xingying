class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :confirmable , :invitable, :encryptable

  has_many :public_accounts
  has_many :tickets
  has_many :comments
  has_many :invitations, :class_name => self.to_s, :as => :invited_by

  mount_uploader :avatar, UserAvatarUploader

  enum role: [:user, :admin, :super_admin]

  def role_enum
    self.class.roles.to_a
  end

  def role= value
    if value.kind_of?(String) and value.to_i.to_s == value
      super value.to_i
    else
      super value
    end
  end

  def timeout_in
    30.minutes
  end

  protected
  def confirmation_required?
    false
  end
end

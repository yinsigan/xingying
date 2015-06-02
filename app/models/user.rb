class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable, :timeoutable, :confirmable , :invitable, :encryptable, :async, :session_limitable

  devise :omniauthable, :omniauth_providers => [:github]

  has_many :public_accounts
  has_many :tickets
  has_many :comments
  has_many :notifications, -> { order "id DESC" }
  has_many :invitations, :class_name => self.to_s, :as => :invited_by

  mount_uploader :avatar, UserAvatarUploader

  enum role: [:user, :admin, :super_admin]

  # 注册邮件提醒
  after_create :send_welcome_mail

  after_commit :send_sign_up_notice, on: :create

  # TODO 当用户存在时，会出问题，需要重构
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
    end
  end

  # def self.new_with_session(params, session)
  #   super.tap do |user|
  #     if data = session["devise.github_data"] && session["devise.github_data"]["extra"]["raw_info"]
  #       user.email = data["email"] if user.email.blank?
  #     end
  #   end
  # end

  def can_admin?
    self.admin? || self.super_admin?
  end

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

  def self.create_sign_up_notification(user_id)
    Notification.create(
      :messageable => User.find_by(:email => Settings.admin_email),
      :tp => 0,
      :subject => "欢迎注册",
      :body => "欢迎您注册成为微媒的新会员，如果在使用上有任何问题，可以随时下服务单联系我们的客服或者查看帮助中心的文档",
      :user_id => user_id
    )
  end

  protected
  def confirmation_required?
    false
  end

  def send_welcome_mail
    UserMailer.delay.welcome(self.id)
  end

  def send_sign_up_notice
    User.delay.create_sign_up_notification(self.id)
  end


end

# coding: utf-8
class UserMailer < BaseMailer
  def welcome(user_id)
    @user = User.find_by(id: user_id)
    return false if @user.blank?
    mail(to: @user.email, subject: t("mail.welcome_subject", app_name: Settings.title))
  end
end

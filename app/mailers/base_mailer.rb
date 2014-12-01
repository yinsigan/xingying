# coding: utf-8
class BaseMailer < ActionMailer::Base
  default from: Settings.office_email
  default charset: "utf-8"
  default content_type: "text/html"
  default_url_options[:host] = Settings.home_url

  layout 'mailer'
end

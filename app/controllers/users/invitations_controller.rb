class Users::InvitationsController < Devise::InvitationsController
  before_filter :configure_permitted_parameters, if: :devise_controller?

  # 重写发送缴请的功能加上发邮件
  def create
    self.resource = invite_resource
    resource_invited = resource.errors.empty?

    yield resource if block_given?

    if resource_invited
      if is_flashing_format? && self.resource.invitation_sent_at
        set_flash_message :notice, :send_instructions, :email => self.resource.email
      end
      resource.deliver_invitation
      respond_with resource, :location => after_invite_path_for(resource)
    else
      respond_with_navigational(resource) { render :new }
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:accept_invitation).concat [:email, :password, :password_confirmation, :invitation_token]
  end


  private

  # this is called when creating invitation
  # should return an instance of resource class
  def invite_resource
    ## skip sending emails on invite
    resource_class.invite!(invite_params, current_inviter) do |u|
      u.skip_invitation = true
    end
  end

  # this is called when accepting invitation
  # should return an instance of resource class
  def accept_resource
    resource = resource_class.accept_invitation!(update_resource_params)
  end
end
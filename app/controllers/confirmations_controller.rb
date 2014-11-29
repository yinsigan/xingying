class ConfirmationsController < Devise::ConfirmationsController
  before_action :authenticate_user!

  protected

  # The path used after resending confirmation instructions.
  def after_resending_confirmation_instructions_path_for(resource_name)
    set_flash_message :notice, :send_instructions
    user_path(resource_name)
  end
end

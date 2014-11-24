class ContactsController < ApplicationController
  def create
    @contact = Contact.new(contact_params)
    @object = @contact
    @flash_success = I18n.t("success_submit")
    render partial: "shared/ajax_prompt.js.erb"
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :phone, :body)
  end
end

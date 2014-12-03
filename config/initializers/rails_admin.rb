RailsAdmin.config do |config|

  ### Popular gems integration
  config.model 'User' do
    object_label_method do
      :email
    end

    edit do
      exclude_fields_if do
        :role == :admin
      end

      exclude_fields :role
    end
  end

  config.model 'Comment' do
    object_label_method do
      :body
    end
  end

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)
  # config.authorize_with do
  #   if current_user
  #     is_admin = current_user.admin? || current_user.super_admin?
  #     redirect_to main_app.new_user_session_url unless is_admin
  #   end
  # end

  config.authorize_with :cancan, AdminAbility
  config.current_user_method &:current_user

  config.model "Support" do
    edit do
      field :title
      field :body, :ck_editor
      field :support_category
    end
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do

    config.main_app_name = Proc.new { |controller| [ "微媒", "后台 - #{controller.params[:action].try(:titleize)}" ] }

    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end

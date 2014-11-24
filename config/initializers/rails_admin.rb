RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)
  config.authorize_with do
    if current_user
      is_admin = current_user.admin? || current_user.super_admin?
      redirect_to main_app.new_user_session_url unless is_admin
    end
  end

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app

    config.model 'User' do
      object_label_method do
        :email
      end
      list do
        field :id
        field :email
        field :created_at
        field :last_sign_in_ip
      end
    end

    config.model 'PublicAccount' do
      object_label_method do
        :email
      end
      list do
        field :id
        field :name
        field :tp do
          pretty_value do
            PublicAccount::TP[value.to_i]
          end
        end
        field :user
        field :image
        field :created_at
        field :weixin_secret_key
        field :weixin_token
        field :appid
        field :appsecret
      end
    end
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end

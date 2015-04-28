require 'sidekiq/web'
Rails.application.routes.draw do

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  mount Ckeditor::Engine => '/ckeditor'
  # 微信公众账号
  resources :public_accounts do
    member do
      # 自动回复
      get :added, to: 'autoreply#added'
      get :reply_content, to: 'autoreply#reply_content'
      # 消息自动回复
      get :autoreply_content, to: 'autoreply#autoreply_content'
      patch :set_default_reply, to: 'autoreply#set_default_reply'
      # 消息自动回复的动作
      patch :set_auto_reply, to: 'autoreply#set_auto_reply'
      get :default, to: 'autoreply#default'
      get :keyword, to: 'autoreply#keyword'
      # 点击选择单图文
      get :select_sin_material, to: "autoreply#select_sin_material"
      get :select_thumb_material, to: "autoreply#select_thumb_material"
      # 选择图片分组
      get "/select_thumb_material/:thumb_group_id", to: "autoreply#select_thumb_material", as: :select_thumb_group_material
      # 素材管理
      get :multi_pic_text, to: "material#multi_pic_text"
      get :delete
      # 查看token
      get :show_token
      patch :toggle_open_customed
    end
    # 自定义菜单
    resources :menus, except: [:show] do
      get :delete, :send_message, :redirect_url, :set_action, on: :member
      post :move_left, :move_right, on: :member
      post :publish_menu, on: :collection
      get :click_content, :check_publish_menu, :check_clear_menu, :clear_menu, on: :collection
    end
    resources :sin_materials, except: [:show] do
      get :delete, on: :member
      get :click_response, on: :collection
    end
    resources :thumbs, only: [:index, :destroy] do
      get :delete, on: :member
      post :upload, :select_upload, :move_group, on: :collection
      get :delete_all, :move, :move_single, on: :collection
      delete :destroy_all, on: :collection
      get "/:thumb_group_id", to: "thumbs#index", on: :collection, as: :group
    end
    resources :thumb_groups, except: [:show, :index] do
      get :delete, on: :member
    end
    resources :rules, except: [:show, :new] do
      # 选择类型
      get :reply_content, :new_kword, :edit_new_kword, on: :collection
      get :delete, :cancel, on: :member
    end
    resources :weixin_groups, only: [:index, :new, :create, :edit] do
      post :rename, on: :collection
      get :request_groups, on: :collection
    end
    resources :weixin_users, only: [:index, :edit] do
      get :request_users, on: :collection
      # 修改备注，已弃用
      # post :remark, on: :collection
    end

    resources :weixin_customs, only: [:index, :new, :create, :edit] do
      get :request_customs, :quality_monitoring, :request_quality_monitoring, :trigger_keyword, on: :collection
      post :rename, on: :collection
      get :delete, :trash, on: :member
    end
  end

  # 帮助
  get "/supports", to: "supports#index", as: :supports
  get "/supports/categories/:support_category_id", to: "supports#index", as: :support_categories
  get "/supports/categories/:support_category_id/articles/:id", to: "supports#show", as: :support

  # 微信上单图文的显示
  get "articles/:id", to: "articles#show", as: :article

  # 联系我们
  post "contacts", to: "contacts#create"

  # 评论
  concern :commentable do
    resources :comments, only: [:create]
  end

  # 微商城
  resources :shops, only: [:index, :show] do
    get :list, :search, :shopping_cart, :orders, :user_center,:orders_list, :orders_show, :collect,on: :collection
  end

  # 消息
  resources :notifications, only: [:create, :index] do
    delete :clear, on: :collection
    get :delete, on: :collection
  end

  resources :tickets, only: [:index, :new, :create, :show], concerns: [:commentable] do
    get :all, on: :collection
  end

  %w(404 422 500).each do |code|
    get code, to: "errors#show", code: code
  end

  devise_for :users, :controllers => { :confirmations => 'confirmations',  :invitations => 'users/invitations', :omniauth_callbacks => "users/omniauth_callbacks" }, skip: :registrations
  # 取消删除用户
  devise_scope :user do
    resource :registration,
      only: [:new, :create, :edit, :update],
      path: 'users',
      path_names: { new: 'sign_up' },
      controller: 'devise/registrations',
      as: :user_registration do
        get :cancel
      end
  end

  root 'home#index'

  resources :users, only: [:show]

  # 微信公众账号接口
  get  'weixin/:weixin_secret_key', to: 'weixin#index', as: :weixin_server
  post 'weixin/:weixin_secret_key', to: 'weixin#reply', as: :weixin_reply

  authenticate :user, lambda { |u| u.super_admin? } do
    mount Sidekiq::Web => '/sidekiq'
  end

  mount RedisBrowser::Web => '/redis-browser'

end

Rails.application.routes.draw do

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
      # 素材管理
      get :multi_pic_text, to: "material#multi_pic_text"
      get :delete
      # 查看token
      get :show_token
      # 选择图片分组
      get "/thumb_group/:thumb_group_id", to: "autoreply#thumb_group", as: :group
      get "/thumb_group", to: "autoreply#thumb_group"
      post :upload, to: "autoreply#upload"

    end
    # 自定义菜单
    resources :menus, except: [:show] do
      get :delete, on: :member
    end
    resources :sin_materials, except: [:show] do
      get :delete, on: :member
      get :click_response, on: :collection
    end
    resources :thumbs, only: [:create, :index, :destroy] do
      get :delete, on: :member
      post :upload, on: :collection
      get :delete_all, :move, :move_single, on: :collection
      delete :destroy_all, on: :collection
      # 移动分组
      post :move_group, on: :collection
      get "/:thumb_group_id", to: "thumbs#index", on: :collection, as: :group
    end
    resources :thumb_groups, except: [:show, :index] do
      get :delete, on: :member
    end
    resources :rules, except: [:show, :new] do
      # 选择类型
      get :reply_content, on: :collection
      get :new_kword, on: :collection
      get :edit_new_kword, on: :collection
      get :delete, on: :member
      get :cancel, on: :member
    end
  end

  get "articles/:id", to: "articles#show", as: :article

  %w(404 422 500).each do |code|
    get code, to: "errors#show", code: code
  end

  devise_for :users
  root 'home#index'

  # 微信公众账号接口
  get  'weixin/:weixin_secret_key', to: 'weixin#index', as: :weixin_server
  post 'weixin/:weixin_secret_key', to: 'weixin#reply', as: :weixin_reply

end

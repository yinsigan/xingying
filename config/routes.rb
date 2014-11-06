Rails.application.routes.draw do

  # 微信公众账号
  resources :public_accounts do
    member do
      # 自动回复
      get :added, to: 'autoreply#added'
      get :reply_content, to: 'autoreply#reply_content'
      patch :set_default_reply, to: 'autoreply#set_default_reply'
      get :default, to: 'autoreply#default'
      get :keyword, to: 'autoreply#keyword'
      get :select_sin_material, to: "autoreply#select_sin_material"
      get :select_thumb_material, to: "autoreply#select_thumb_material"
      # 素材管理
      get :multi_pic_text, to: "material#multi_pic_text"
      get :delete
      get :show_token
      # 选择图片分组
      get "/thumb_group/:thumb_group_id", to: "autoreply#thumb_group", as: :group
      get "/thumb_group", to: "autoreply#thumb_group"
    end
    resources :sin_materials, except: [:show] do
      get :delete, on: :member
    end
    resources :thumbs, only: [:create, :index, :destroy] do
      get :delete, on: :member
      post :upload, on: :collection
      get :delete_all, :move, :move_single, on: :collection
      delete :destroy_all, on: :collection
      post :move_group, on: :collection
      get "/:thumb_group_id", to: "thumbs#index", on: :collection, as: :group
    end
    resources :thumb_groups, only: [:new, :create, :destroy, :edit, :update] do
      get :delete, on: :member
    end
    resources :rules, only: [:index, :create, :destroy, :edit, :update] do
      get :reply_content, on: :collection
      get :new_kword, on: :collection
      get :delete, on: :member
    end
  end

  %w(404 422 500).each do |code|
    get code, to: "errors#show", code: code
  end

  devise_for :users
  root 'home#index'

  # 微信公众账号接口
  get  'weixin/:weixin_secret_key', to: 'weixin#index', as: :weixin_server
  post 'weixin/:weixin_secret_key', to: 'weixin#reply', as: :weixin_reply

end

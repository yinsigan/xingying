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
      # 素材管理
      get :multi_pic_text, to: "material#multi_pic_text"
      get :delete
      get :show_token
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
  end

  %w(404 422 500).each do |code|
    get code, to: "errors#show", code: code
  end

  devise_for :users
  root 'home#index'

  # 微信公众账号接口
  get  'weixin/:weixin_secret_key', to: 'weixin#index', as: :weixin_server
  post 'weixin/:weixin_secret_key', to: 'weixin#reply', as: :weixin_reply

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

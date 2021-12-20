Rails.application.routes.draw do
   root to: 'homes#top'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :admin do
    root to: 'books#index'
    resources :books, only: [:show, :destroy]
    resources :customers, only:[:show, :destroy, :index]
    patch 'customers/withdraw/:id', to: 'customers#withdraw'
  end

  namespace :public do
    # ↓いいね、コメント機能
    resources :books, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
    resource :favorites, only: [:create, :destroy]
    resources :book_comments, only: [:create, :destroy]
   end
    resources :customers, only:[:show, :edit, :update, :index]
    get 'customers/unsubscribe'
    patch 'customers/withdraw/:id', to: 'customers#withdraw'
  end

    # 顧客用
    # URL /customers/sign_in ...
    devise_for :customers,skip: [:passwords], controllers: {registrations: "public/registrations", sessions: 'public/sessions'}

    # 管理者用
    # URL /admin/sign_in ...
    devise_for :admin, skip: [:registrations, :passwords] ,controllers: {sessions: "admin/sessions"}

end
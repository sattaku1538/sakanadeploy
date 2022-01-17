Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'homes/about'
  get '/search', to: 'searchs#search'

  namespace :admin do
    root to: 'books#index'
    resources :books, only: [:show, :destroy]
    resources :customers, only:[:show, :destroy, :index]
    patch 'customers/withdraw/:id', to: 'customers#withdraw'
  end

  namespace :public do
    # ↓いいね、コメント機能
    resources :books, only: [:new, :index, :show, :edit, :create, :destroy, :update] do
      resources :book_comments, only: [:create, :destroy]
      resource :favorites, only: [:create, :destroy]
    end

    resources :customers, only:[:show, :edit, :update, :index] do
      member do
        get :unsubscribe
      end
    end
    patch 'customers/withdraw/:id', to: 'customers#withdraw'
  end

  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {registrations: "public/registrations", sessions: 'public/sessions'}

  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {sessions: "admin/sessions"}

end
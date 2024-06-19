Rails.application.routes.draw do
  devise_for :users
  root to: "prototypes#index"
  resources :prototypes, only: [:index, :new, :create, :show, :edit, :update, :destroy] do
    # resourcesを用いて、設定したcreateアクションに対するルーティングをroutes.rbに記述した
    resources :comments, only: [:create]
  end
  resources :users, only: :show
end

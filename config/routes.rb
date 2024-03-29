Rails.application.routes.draw do
  # root '/'
  devise_for :users, path: 'auth', path_names: { sign_in: 'login', sign_out: 'logout', password: 'secret', registration: 'register', sign_up: 'cmon_let_me_in' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  scope :management, module: :admin do
    root to: "dashboard#index"
    resources :dashboard
    resources :accounts
    resources :transactions
  end

  namespace :api do
    post 'authenticate', to: 'authentication#authenticate'
    resources :users, param: :user_id do
      member do
        resources :transactions
      end
    end
  end
end

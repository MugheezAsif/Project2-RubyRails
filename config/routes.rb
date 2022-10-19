Rails.application.routes.draw do
  get 'checkout/create'
  resources :buyer_portal, only: [:index]
  post 'checkout/create', to: 'checkout#create'
  get 'checkout_success', to: 'checkout#success'
  get 'checkout_cancel', to: 'checkout#cancel'
  get 'admin_portal/index'
  get 'contacts/request_account'
  get 'admin_portal/user_details'
  get 'admin_portal/payment_request'

  resources :contacts, only: %i[new create]
  devise_for :users, controllers: { sessions: 'users/sessions' }, skip: [:registrations]
  as :user do
    get 'users/edit', to: 'devise/registrations#edit', as: 'edit_user_registration'
    put 'users', to: 'devise/registrations#update', as: 'user_registration'
    get 'users/cancel', to: 'devise/registrations#cancel', as: 'cancel_user_registration'
    delete 'users', to: 'devise/registrations#destroy'
  end
  resources :plans do
    resources :features
    get 'subscription/subscribe'
    get 'subscription/add_usage', to: 'subscription#add_usage'
    get 'subscription/details'
    delete 'subscriptions', to: 'subscription#destroy'
  end
  root 'welcome#index'
  get 'profile', to: 'profile#index', as: 'profile'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end

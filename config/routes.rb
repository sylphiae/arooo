Doubleunion::Application.routes.draw do
  root to: 'sessions#login'

  namespace :members do
    root to: 'users#index'

    resources :users, only: [:index, :show, :edit, :update] do
      get 'setup' => "users#setup"
      patch 'setup' => "users#finalize"
      get 'dues' => "users#dues"
      post 'dues' => "users#submit_dues_to_stripe"

      resource :status, only: [:edit, :update]
    end
    resources :votes, only: [:create, :destroy]

    resources :applications, only: [:index, :show] do
      resources :comments, only: :create
      post 'sponsor' => "applications#sponsor"
    end

    resources :caches, only: :index do
      post :expire, on: :collection
    end
  end

  namespace :admin do
    resource :exceptions, only: :show
  end

  get 'admin/new_members' => 'admin#new_members'
  get 'admin/applications' => 'admin#applications'
  get 'admin/members' => 'admin#members'
  get 'admin/dues' => 'admin#dues'

  patch 'admin/approve' => 'admin#approve'
  patch 'admin/reject' => 'admin#reject'

  post 'admin/setup_complete' => 'admin#setup_complete'
  post 'admin/save_membership_note' => 'admin#save_membership_note'

  patch 'admin/add_voting_member' => 'admin#add_voting_member'
  patch 'admin/add_key_member' => 'admin#add_key_member'
  patch 'admin/revoke_voting_member' => 'admin#revoke_voting_member'
  patch 'admin/revoke_key_member' => 'admin#revoke_key_member'
  patch 'admin/revoke_membership' => 'admin#revoke_membership'

  resources :applications, only: [:new, :show, :edit, :update]

  get 'auth/:provider/callback' => 'sessions#create'
  get 'github_login' => 'sessions#github'
  get 'google_login' => 'sessions#google'
  get 'login' => 'sessions#login'
  get 'logout' => 'sessions#destroy'
  get 'auth/failure' => 'sessions#failure'
  get 'get_email' => 'sessions#get_email'
  post 'confirm_email' => 'sessions#confirm_email'

  post 'add_github_auth' => 'authentications#add_github_auth'
  post 'add_google_auth' => 'authentications#add_google_auth'

  get 'public_members' => 'api#public_members'
  get 'configurations' => 'api#configurations'

  mount StripeEvent::Engine => '/stripe'
end

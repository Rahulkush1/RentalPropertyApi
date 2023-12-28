Rails.application.routes.draw do
  mount Avo::Engine, at: Avo.configuration.root_path
  post "/auth/google_oauth2"
  get "/auth/google_oauth2/callback", to: "users/sessions#omniauth_login"
  namespace :api do
    namespace :v1 do
      namespace :users do
        resources :registerations, :only => [:create] do 
          collection do 
            put :update
            delete :destroy
            put :email_confirm
            post :send_otp_code
          end
        end
        resources :sessions, :only => [:create] do 
          collection do
            get :show 

          end
        end
        resources :appointments, :only => [:create] do 
          collection do 
            get :index 
            put :update
            delete :destroy
          end
        end
      end
      resources :properties, :only => [:create] do
        collection do 
          get :index
          put :update
          delete :destroy
          get :filter_property
          get :property_detail
          delete :delete_image_attachment
        end
      end
      resources :payouts, :only => [:index, :create]
      post '/create_payment_intent', to: "payments#create_payment_intent"
      get '/payment_confirmation', to: "payments#payment_confirmation"
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # authenticate :admin_users do
  #   mount Avo::Engine, at: Avo.configuration.root_path
  # end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root "articles#index"
end

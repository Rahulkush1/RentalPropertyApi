Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :users do
        resources :registerations, :only => [:create] do 
          collection do 
            put :update
            delete :destroy
            put :email_confirm
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
    end
  end

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # root "articles#index"
end

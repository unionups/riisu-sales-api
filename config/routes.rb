Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # unauthenticated routes
      post '/start_verification', to: 'sessions#new'
      post '/confirm_verification', to: 'sessions#create'
      
      constraints Constraints::UserConstraint do
        constraints Constraints::AdminConstraint do
          scope module: 'admin' do
            # authenticated :admin role routes
            resources :users
            resources :places
          end
        end
        # authenticated :user role routes
        resources :users, only: [:show, :update]
        resources :places, only: [:index, :show]
        resources :claims, except: [:destroy]
        get  '/claims/:id/cancel',  to: "claims#cancel", as: :cancel_claim
        post '/claims/:id/accept',  to: "claims#accept", as: :accept_claim
        post '/claims/:id/decline', to: "claims#decline", as: :decline_claim
      end
    end
  end
end

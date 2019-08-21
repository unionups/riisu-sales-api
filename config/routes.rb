Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # unauthenticated routes
      post '/start_verification', to: 'sessions#new'
      post '/confirm_verification', to: 'sessions#create'
      constraints Constraints::UserConstraint do
        # authenticated :user role routes
      end
      constraints Constraints::AdminConstraint do
        scope module: 'admin' do
          # authenticated :admin role routes
         
        end
      end
    end
  end
end

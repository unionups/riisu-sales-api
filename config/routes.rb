Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			post '/start_verification', to: 'sessions#new'
      post '/confirm_verification', to: 'sessions#create'
			constraints Constraints::UserConstraint do

			end
			constraints Constraints::AdminConstraint do
				scope module: 'admin' do
				 
				end
			end
		end
	end
end

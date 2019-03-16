Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
		  post "/current-user" => "users#current_user"
			post "/requests/:id/approve" => "requests#approve"
			resources :requests
		  resources :users, only:[:index,:show,:create,:update,:destroy]
		  post "/friends" => "friendships#friends"
		  post "/login" => "users#login"
		  post "/sign-up" => "users#sign_up"
		  mount ActionCable.server => '/cable'
		end
	end
end

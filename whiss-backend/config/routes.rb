Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
			post "/requests/:id/approve" => "requests#approve"
			resources :requests
			resources :friendships
		  resources :users, only:[:index,:show,:create,:update,:destroy]
		  post "/login" => "users#login"
		  post "/sign-up" => "users#sign_up"
		  post "/logout" => "users#logout"
		  mount ActionCable.server => '/cable'
		end
	end
end

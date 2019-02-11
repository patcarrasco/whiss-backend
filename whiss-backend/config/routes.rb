Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do		  
		  resources :users, only:[:index,:show,:create,:update,:destroy]
		  post "/login" => "users#login"
		  post "/logout" => "users#logout"
		  mount ActionCable.server => '/cable'
		end
	end
end

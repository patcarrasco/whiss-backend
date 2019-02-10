Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	namespace :api do
		namespace :v1 do
		  get "/users/:user_id/chats", to: "chats#user_chats", as: "user_chats"
		  get "/chats/:chat_id/messages", to: "messages#chat_messages", as: "chat_messages"
		  
		  resources :users, only:[:index,:show,:create,:update,:destroy]
		  resources :chats, only:[:index,:show,:create,:update,:destroy]
		  resources :messages, only:[:index,:show,:create,:update,:destroy]

		  mount ActionCable.server => '/cable'
		end
	end
end

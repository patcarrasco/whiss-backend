Rails.application.routes.draw do
	namespace :api do
		namespace :v1 do
		  get "/users/:user_id/chats", to: "chats#user_chats"
		  get "/chats/:chat_id/messages", to: "messages#chat_messages"
		  
		  resources :users, only:[:index,:show,:create,:update,:destroy]
		  resources :chats, only:[:index,:show,:create,:update,:destroy]
		  resources :user_chats, only:[:create,:destroy]
		  resources :messages, only:[:index,:show,:create,:update,:destroy]

		  mount ActionCable.server => '/cable'
		end
	end
end

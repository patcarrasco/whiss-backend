class User < ApplicationRecord
	has_many :user_chats, dependent: :destroy
	has_many :chats, through: :user_chats
	has_many :messages, dependent: :destroy

	validates_uniqueness_of :username
	
	has_secure_password
end
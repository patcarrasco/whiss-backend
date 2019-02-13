class User < ApplicationRecord
	has_many :user_chats, dependent: :destroy
	has_many :chats, through: :user_chats
	has_many :messages, dependent: :destroy
	has_many :sent_requests, class_name: "Request", dependent: :destroy, foreign_key: :sender_id
	has_many :received_requests, class_name: "Request", dependent: :destroy, foreign_key: :receiver_id
	has_many :friendships1, class_name: "Friendship", dependent: :destroy, foreign_key: :friend1_id
	has_many :friendships2, class_name: "Friendship", dependent: :destroy, foreign_key: :friend2_id

	validates_uniqueness_of :username
	
	has_secure_password

	def friends
		self.friendships2 + self.friendships1
	end
	
	def friendships
		self.friendships2 + self.friendships1
	end
end
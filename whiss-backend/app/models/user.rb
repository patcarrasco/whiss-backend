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
		friends1 = self.friendships1.map {|f| f.friend2}
		friends2 = self.friendships2.map {|f| f.friend1}
		friends1 + friends2
	end
	def other_users
		User.select {|user| user.id != self.id}
	end
end
class User < ApplicationRecord
	has_many :sent_chats, class_name: "Chat", foreign_key: :sender_id, dependent: :destroy
	has_many :received_chats, class_name: "Chat", foreign_key: :receiver_id, dependent: :destroy
	has_many :messages

	validates_uniqueness_of :username

	has_secure_password

	def chats
		self.sent_chats + self.received_chats
	end
end
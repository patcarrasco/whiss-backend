class UserChat < ApplicationRecord
	belongs_to :user
	belongs_to :chat

	validates_uniqueness_of :user_id, scope: :chat_id
	validates_presence_of :user_id, :chat_id
end
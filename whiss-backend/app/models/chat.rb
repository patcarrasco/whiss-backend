class Chat < ApplicationRecord
	belongs_to :sender, class_name: "User"
	belongs_to :receiver, class_name: "User"
	has_many :messages, dependent: :destroy

	validates_uniqueness_of :sender_id, scope: :receiver_id

	scope :between, -> (sender_id, receiver_id) do
  	where("(chats.sender_id = ? AND chats.receiver_id = ?) OR (chats.receiver_id = ? AND chats.sender_id = ?)", sender_id, receiver_id, sender_id, receiver_id)
  end

	def member?(user)
		user.id == receiver_id || user.id == sender_id
	end
end
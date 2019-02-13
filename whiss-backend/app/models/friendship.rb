class Friendship < ApplicationRecord
	belongs_to :friend1, class_name: "User"
	belongs_to :friend2, class_name: "User"

	validates_uniqueness_of :friend1_id, scope: :friend2_id

	scope :between, -> (friend1_id, friend2_id) do
    where("(friendships.friend1_id = ? AND friendships.friend2_id = ?) OR (friendships.friend2_id = ? AND friendships.friend1_id = ?)", friend1_id, friend2_id, friend1_id, friend2_id)
  end
end

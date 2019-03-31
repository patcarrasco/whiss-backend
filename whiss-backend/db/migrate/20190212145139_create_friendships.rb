class CreateFriendships < ActiveRecord::Migration[5.2]
	def change
		create_table :friendships do |t|
			t.belongs_to :friend1
			t.belongs_to :friend2
			t.timestamps
		end
	end
end

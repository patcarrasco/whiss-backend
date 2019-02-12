class AddImageUrlToUserAndChat < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :image_url, :string
  	add_column :chats, :image_url, :string
  end
end

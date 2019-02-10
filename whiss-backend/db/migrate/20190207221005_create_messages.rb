class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.belongs_to :user
      t.belongs_to :chat
      t.text :content
    end
  end
end

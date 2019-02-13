class CreateRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :requests do |t|
      t.belongs_to :sender
      t.belongs_to :receiver
      t.boolean :approved, null: false, default: false
      t.timestamps
    end
  end
end

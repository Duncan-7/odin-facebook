class CreateFriendRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :friend_requests do |t|
      t.belongs_to :sender, foreign_key: true
      t.belongs_to :receiver
      t.timestamps
    end
  end
end

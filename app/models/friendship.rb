class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  after_save :mirror_friendship
  after_destroy :mirror_destruction
  private

    def mirror_friendship
      Friendship.find_or_create_by(user_id: friend.id, friend_id: user.id)
    end

    def mirror_destruction
      if friendship = Friendship.find_by(user_id: friend.id, friend_id: user.id)
        friendship.destroy
      end
    end
end

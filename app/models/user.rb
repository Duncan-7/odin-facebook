class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, class_name: "User"
  has_many :sent_requests, foreign_key: :sender_id, class_name: "FriendRequest", dependent: :destroy
  has_many :received_requests, foreign_key: :receiver_id, class_name: "FriendRequest", dependent: :destroy
  has_many :posts
  has_many :comments, through: :posts

  validates :name, presence: true, length: { maximum: 50 }

  def send_friend_request(other_user)
    sent_requests << other_user
  end

  def cancel_friend_request(other_user)
    sent_requests.delete(other_user)
  end

  def sent_friend_request?(other_user)
    sent_requests.include?(other_user)
  end
  
  def add_friend(other_user)
    friends << other_user
  end

  def remove_friend(other_user)
    friends.delete(other_user)
  end

  def friends?(other_user)
    friends.include?(other_user)
  end
end

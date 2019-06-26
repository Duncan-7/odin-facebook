class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships, class_name: "User"
  has_many :sent_requests, foreign_key: :sender_id, class_name: "FriendRequest", dependent: :destroy
  has_many :received_requests, foreign_key: :receiver_id, class_name: "FriendRequest", dependent: :destroy
end

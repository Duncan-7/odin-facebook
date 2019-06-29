class Post < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :likes

  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 2000 }
end

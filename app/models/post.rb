class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community
  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  def liked_by?(user)
    return false unless user
    likes.exists?(user_id: user.id)
  end
end

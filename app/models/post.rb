class Post < ApplicationRecord
  belongs_to :user
  belongs_to :community

  validates :content, presence: true,
                      length: { maximum: 140}

  has_many :likes, dependent: :destroy
  has_many :liked_users, through: :likes, source: :user

  has_one_attached :image

  def liked_by?(user)
    return false unless user
    likes.exists?(user_id: user.id)
  end
end

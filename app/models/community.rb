class Community < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user


  enum category: {
    ski: 0,
    snowboard: 1,
    resort: 2,
    gear: 3,
    beginner: 4,
    other: 5
  }
end
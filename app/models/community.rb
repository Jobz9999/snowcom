class Community < ApplicationRecord
  belongs_to :user
  has_many :posts, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user
end

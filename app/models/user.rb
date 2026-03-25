class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true,
                   length: { maximum: 20}
  
  validates :profile, length: { maximum: 200}

  has_many :communities, dependent: :destroy
  has_many :posts, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :joined_communities, through: :memberships, source: :community
  has_many :likes, dependent: :destroy
  has_many :liked_posts, through: :likes,source: :post
end
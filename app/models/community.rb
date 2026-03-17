class Community < ApplicationRecord
  belongs_to :user
  belongs_to :category, optional: true
  has_many :posts, dependent: :destroy
  has_many :memberships, dependent: :destroy
  has_many :members, through: :memberships, source: :user

  after_create :join_owner!

  private

  def join_owner!
    return unless user_id
    memberships.find_or_create_by!(user_id: user_id) do |membership|
      membership.status = :approved
    end
  end
end
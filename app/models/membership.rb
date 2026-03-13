class Membership < ApplicationRecord
  belongs_to :user
  belongs_to :community
  
  enum status: { pending: 0, approved: 1 }
end

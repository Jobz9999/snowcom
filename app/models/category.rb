class Category < ApplicationRecord
  has_many :communities, dependent: :nullify
end

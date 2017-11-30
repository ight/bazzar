class Category < ApplicationRecord

  # Associations
  has_many :items, inverse_of: :category
  has_many :brands, inverse_of: :category
end
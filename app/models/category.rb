class Category < ApplicationRecord

  # Associations
  has_many :items, inverse_of: :category
  has_many :brands, inverse_of: :category

  # Validations
  validates :category_name, uniqueness: true
end
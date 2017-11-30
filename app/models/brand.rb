class Brand < ApplicationRecord

  # Associations
  belongs_to :category, inverse_of: :brands
  has_many :items, inverse_of: :brand
end

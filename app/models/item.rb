class Item < ApplicationRecord

  # Associations
  belongs_to :category, inverse_of: :items
  belongs_to :brand, inverse_of: :items
  has_many :cart_items, inverse_of: :item
  has_many :users, through: :cart_items
end

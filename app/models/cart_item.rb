class CartItem < ApplicationRecord

  # Association
  belongs_to :item, inverse_of: :cart_items
  belongs_to :user, inverse_of: :cart_items
end

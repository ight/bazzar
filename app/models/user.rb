class User < ApplicationRecord

  #Associations
  has_many :cart_items, inverse_of: :user
  has_many :items, through: :cart_items
end

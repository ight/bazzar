class AddIndexToUser < ActiveRecord::Migration[5.0]
  def change
  add_index :users, :contact_number
  add_index :users, :email
  add_index :cart_items, :item_id
  add_index :cart_items, :user_id
  end
end

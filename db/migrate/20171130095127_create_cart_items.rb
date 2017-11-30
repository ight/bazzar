class CreateCartItems < ActiveRecord::Migration[5.0]
  def change
    create_table :cart_items do |t|
    	t.integer :item_id
    	t.integer :user_id
    	t.boolean :processed, null: false, default: false
      t.timestamps
    end
  end
end

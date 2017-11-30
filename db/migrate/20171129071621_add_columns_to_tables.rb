class AddColumnsToTables < ActiveRecord::Migration[5.0]
  def change
    add_column :items, :brand_id, :integer
    add_column :items, :category_id, :integer
    add_column :brands, :category_id, :integer
    add_index :items, :brand_id
    add_index :items, :category_id
    add_index :brands, :category_id
  end
end

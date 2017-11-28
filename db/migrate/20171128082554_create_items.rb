class CreateItems < ActiveRecord::Migration[5.0]
  def change
    create_table :items do |t|
      t.string :name, null: false
      t.string :price, null: false
      t.string :code, null: false
      t.timestamps
    end
    add_index :items, :code, unique: true
  end
end
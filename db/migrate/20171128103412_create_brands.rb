class CreateBrands < ActiveRecord::Migration[5.0]
  def change
    create_table :brands do |t|
      t.string :name, null: false, default: "Bazzar"
      t.timestamps
    end
  end
end

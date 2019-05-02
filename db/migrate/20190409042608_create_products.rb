class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.text :information
      t.text :image
      t.boolean :classify
      t.integer :quantity

      t.timestamps
    end
    add_index :products, [:created_at]
  end
end

class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.references :category, null: true, foreign_key: true
      t.integer :price, null: false, default: 5
      t.string :image

      t.timestamps
    end
  end
end

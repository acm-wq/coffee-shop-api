class CreateCategories < ActiveRecord::Migration[8.0]
  def change
    create_table :categories do |t|
      t.string :name, null: false, index: { unique: true }
      t.text :description, default: 'No description'

      t.timestamps
    end
  end
end

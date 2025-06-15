class CreateRoles < ActiveRecord::Migration[8.0]
  def change
    create_table :roles do |t|
      t.integer :role_type, default: 0, null: false

      t.timestamps
    end
  end
end

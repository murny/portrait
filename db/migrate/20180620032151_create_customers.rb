class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :name,                         null: false
      t.boolean :active,      default: false, null: false
      t.integer :users_count, default: 0,     null: false

      t.timestamps
    end
  end
end

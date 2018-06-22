class CreateTiers < ActiveRecord::Migration[5.2]
  def change
    create_table :tiers do |t|
      t.string :name,      null: false
      t.decimal :price,    null: false, precision: 8, scale: 2, default: 0.0
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end
  end
end

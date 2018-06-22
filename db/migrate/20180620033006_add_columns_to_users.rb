class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_reference :users, :customer, foreign_key: true
  end
end

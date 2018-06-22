class AddTierToCustomers < ActiveRecord::Migration[5.2]
  def change
    add_reference :customers, :tier, foreign_key: true
  end
end
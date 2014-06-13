class AddLetterIdToLetterOrders < ActiveRecord::Migration
  def change
    add_column :letter_orders, :letter_id, :integer
  end
end

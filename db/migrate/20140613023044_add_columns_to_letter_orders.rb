class AddColumnsToLetterOrders < ActiveRecord::Migration
  def change
    add_column :letter_orders, :user_id, :integer
  end
end

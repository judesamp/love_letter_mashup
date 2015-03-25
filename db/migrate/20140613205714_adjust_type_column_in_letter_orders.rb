class AdjustTypeColumnInLetterOrders < ActiveRecord::Migration
  def change
  	remove_column :letter_orders, :type, :string
  	add_column :letter_orders, :delivery_type, :string
  end
end

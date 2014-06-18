class AddCustomMessageToLetterOrders < ActiveRecord::Migration
  def change
  	add_column :letter_orders, :custom_message, :text
  end
end

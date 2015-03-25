class AddSnailMailColumnsToLetterOrders < ActiveRecord::Migration
  def change
  	add_column :letter_orders, :address_line_1, :string
  	add_column :letter_orders, :address_line_2, :string
  	add_column :letter_orders, :city, 					:string
  	add_column :letter_orders, :state, 					:string
  	add_column :letter_orders, :zip_code, 			:string

  end
end
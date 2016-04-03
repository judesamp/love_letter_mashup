class AddFieldsToLetter < ActiveRecord::Migration
  def change
    add_column :letter_orders, :recipient, :string
    add_column :letter_orders, :signature, :string
  end
end

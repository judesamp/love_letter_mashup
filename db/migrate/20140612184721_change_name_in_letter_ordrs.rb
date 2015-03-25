class ChangeNameInLetterOrdrs < ActiveRecord::Migration
  def change
    rename_column :letter_orders, :recipient, :recipient_name
  end
end

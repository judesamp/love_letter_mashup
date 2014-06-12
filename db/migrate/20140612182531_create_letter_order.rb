class CreateLetterOrder < ActiveRecord::Migration
  def change
    create_table :letter_orders do |t|
      t.string :recipient_email
      t.string :type

      t.timestamps
    end
  end
end

class CreateLetters < ActiveRecord::Migration
  def change
    create_table :letters do |t|
      t.integer :user_id
      t.text :content
      t.integer :author_id

      t.timestamps
    end
  end
end

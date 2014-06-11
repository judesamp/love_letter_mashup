class AddLetterableColumnsToLetters < ActiveRecord::Migration
  def change
    add_column :letters, :letterable_id, :integer
    add_column :letters, :letterable_type, :string
    remove_column :letters, :user_id, :integer
    remove_column :letters, :author_id, :integer
  end
end

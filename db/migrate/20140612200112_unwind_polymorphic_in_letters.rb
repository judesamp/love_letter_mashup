class UnwindPolymorphicInLetters < ActiveRecord::Migration
  def change
    remove_column :letters, :letterable_id, :integer
    remove_column :letters, :letterable_type, :integer
    add_column :letters, :user_id, :integer
    add_column :letters, :author_id, :integer
  end
end
class RemoveColumnFromLetters < ActiveRecord::Migration
  def change
    remove_column :letters, :user_id, :integer
  end
end

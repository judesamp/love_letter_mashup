class AlterAuthorsToIncludeFirstAndLastName < ActiveRecord::Migration
  def change
    remove_column :authors, :name, :string
    add_column :authors, :first_name, :string
    add_column :authors, :last_name, :string
  end
end

class AddAuthorIdToSnippets < ActiveRecord::Migration
  def change
  	add_column :snippets, :author_id, :integer
  end
end

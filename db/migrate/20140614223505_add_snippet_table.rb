class AddSnippetTable < ActiveRecord::Migration
  def change
  	create_table :snippets do |t|
      t.string :content
    end
  end
end

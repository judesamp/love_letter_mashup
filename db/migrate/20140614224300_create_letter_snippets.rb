class CreateLetterSnippets < ActiveRecord::Migration
  def change
    create_table :letter_snippets do |t|
      t.integer :letter_id
      t.integer :snippet_id
      t.integer :position
    end
  end
end

class LetterSnippet < ActiveRecord::Base
	belongs_to :letter
	belongs_to :snippet
end
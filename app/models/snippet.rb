class Snippet < ActiveRecord::Base
	belongs_to :author
	has_many :letter_snippets
	has_many :letters, through: :letter_snippets


	scope :by_position, -> { order('position asc') }
	
end